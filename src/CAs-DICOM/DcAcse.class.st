"
Association Control Service Elements (ACSEs)

https://docsbay.net/association-control-service-element-acse-is-the-osi-method-for-establishing-a-call-between
"
Class {
	#name : #DcAcse,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcAcse class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
DcAcse class >> reset [
<script>
	default := nil
]

{ #category : #public }
DcAcse >> abort: aRequest forAssoc: anAssoc [

	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'A-ABORT message recieved'.
	anAssoc release.
	ConnectionClosed signal.
	^ nil
]

{ #category : #public }
DcAcse >> associateAc: aRequest forAssoc: anAssoc [

	| ae respPresCtx | 
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'A-ASSOCIATE-AC message recieved'.
	respPresCtx := aRequest getPresentationContexts.
	self halt
]

{ #category : #public }
DcAcse >> associateRq: aRequest forAssoc: anAssoc [

	| ae resp respPresCtx ui |
	self traceCr: DateAndTime current asStringYMDHMS ,  ' ' , self class name ,  ' '
				,'A-ASSOCIATE-RQ message recieved'.
	aRequest validateAppContext ifFalse: [ 
		^ DcAssociateRj invalidAppContext ].
	[ ae := DcAeDirectory ourAET: aRequest calledAET ]
		on: KeyNotFound
		do: [ ^ DcAssociateRj aeNotrecognized ].
	anAssoc ae: ae default.
	anAssoc dimse: ae default dimse.
	resp := DcAssociateAc new.
	resp rq: aRequest.
	respPresCtx := aRequest getPresentationContexts collect: [ :px | 
		               self selectTransferSyntax: px ].
	respPresCtx do: [ :pctx | resp addItem: pctx ].
	anAssoc selectedPresCtxs: respPresCtx.
	ui := DcItemUserInformation new standard.
	resp addItem: ui.
	resp checkLength.
	^ resp
]

{ #category : #public }
DcAcse >> connectAssoc: assoc param: aParamDict [

	| req pdu |
	req := DcAssociateRq new. 
	req callingAET: assoc ae aeTitle.
	req calledAET: assoc remoteAETitle.
	req addStandardItems.
	pdu := DcUpperLayerClient default associate: req forAssoc: assoc.
	self indication: pdu forAssoc: assoc.
	^ assoc
]

{ #category : #public }
DcAcse >> indication: aRequest forAssoc: anAssoc [

	| resp |
	DcAssociateRq = aRequest class ifTrue: [ 
		resp := self associateRq: aRequest forAssoc: anAssoc ].
	DcAssociateAc = aRequest class ifTrue: [ 
		resp := self associateAc: aRequest forAssoc: anAssoc ].
	DcAbort = aRequest class ifTrue: [ 
		resp := self abort: aRequest forAssoc: anAssoc ].
	DcAssociateRj = aRequest class ifTrue: [ 
		resp := self associateRj: aRequest forAssoc: anAssoc ].
	DcReleaseRq = aRequest class ifTrue: [ 
		resp := self releaseRq: aRequest forAssoc: anAssoc ].
	DcReleaseRp = aRequest class ifTrue: [ 
		resp := self releaseRp: aRequest forAssoc: anAssoc ].
	^ resp
]

{ #category : #public }
DcAcse >> releaseRq: aRequest forAssoc: anAssoc [

	| resp |
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'A-RELEASE-RQ message recieved'.
		anAssoc release.
	resp := DcReleaseRp new.
	^ resp
]

{ #category : #public }
DcAcse >> selectTransferSyntax: px [

	| asnEcho asn tsn okTsn selTsn newItems |
	asnEcho := '1.2.840.10008.1.1'.
	asn := px items first.
	tsn := px items allButFirst.
	okTsn := tsn select: [ :t | t = '1.2.840.10008.1.2' ].
	selTsn := okTsn first.
	newItems := SortedCollection new
		            add: asn;
		            add: selTsn;
		            yourself.
	px replaceItems: newItems.
	px resultReason: 0."accepted"
	^ px
]
