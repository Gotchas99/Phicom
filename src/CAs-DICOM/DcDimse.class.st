Class {
	#name : #DcDimse,
	#superclass : #Object,
	#instVars : [
		'ae'
	],
	#classVars : [
		'CmdCode'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'class initialization' }
DcDimse class >> cmdAt: aCode [

	

	^ CmdCode at:aCode
]

{ #category : #'class initialization' }
DcDimse class >> cmdAtName: aName [

	^ CmdCode keyAtValue:  aName
]

{ #category : #'class initialization' }
DcDimse class >> cmdCodeText [

	^ '0001H C-STORE-RQ

8001H C-STORE-RSP

0010H C-GET-RQ

8010H C-GET-RSP

0020H C-FIND-RQ

8020H C-FIND-RSP

0021H C-MOVE-RQ

8021H C-MOVE-RSP

0030H C-ECHO-RQ

8030H C-ECHO-RSP

0100H N-EVENT-REPORT-RQ

8100H N-EVENT-REPORT-RSP

0110H N-GET-RQ

8110H N-GET-RSP

0120H N-SET-RQ

8120H N-SET-RSP

0130H N-ACTION-RQ

8130H N-ACTION-RSP

0140H N-CREATE-RQ

8140H N-CREATE-RSP

0150H N-DELETE-RQ

8150H N-DELETE-RSP

0FFFH C-CANCEL-RQ'
]

{ #category : #'class initialization' }
DcDimse class >> initialize [

self initializeCmdCode
]

{ #category : #'class initialization' }
DcDimse class >> initializeCmdCode [

	| lines f code |
	CmdCode := Dictionary new.
	lines := self cmdCodeText lines reject: [ :aLine | aLine isEmpty ].
	lines do: [ :aLine | 
		f := ' ' split: aLine.
		code := self parseHex: f first .
		CmdCode at:code put:f second].^CmdCode
]

{ #category : #parsing }
DcDimse class >> parseHex: aHexString [

	^ (aHexString copyWithoutAll: 'H')
		  inject: 0
		  into: [ :sum :each | sum * 16 + each hexDigitValue ]
]

{ #category : #accessing }
DcDimse >> ae: anAE [

	| dul |
	ae := anAE.
	dul := DcUpperLayerServer default.
	dul registerDimse: self for: ae aeTitle
]

{ #category : #helper }
DcDimse >> fragsFromElements: els [

	| frags len frag maxLen |
	maxLen := 16000. "Find this somewhere"
	frags := OrderedCollection with: OrderedCollection new.
	len := 0.
	els do: [ :el |  
		frag := frags last.
		len := len + el groupLength.
		len > maxLen ifTrue: [ "adding returns the added object"
			frag := frags add: OrderedCollection new.
			len := el groupLength ].
		frag add: el ].
	^ frags
]

{ #category : #services }
DcDimse >> indicationService: service param: param forAssoc: anAssoc [

	| resp |
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'indication recieved.service: ' , service.

	#pData = service ifTrue: [ 
		self pData: param forAssoc: anAssoc.
		resp := nil ].

	^ resp
]

{ #category : #helper }
DcDimse >> messageForService: service param: param forAssoc: anAssoc [

	| msg sop ctxid |
	param messageType: service.
	msg := param asMessage.
	sop := msg sopClassUid.
	ctxid := anAssoc ctxidForSopUid: sop.
	msg ctxid:ctxid.
	msg addCommandGroupLength.
	^ msg
]

{ #category : #services }
DcDimse >> pData: pdvList forAssoc: anAssoc [

	| element fs ctx msg cmd param |
	pdvList do: [ :pdv | 
		ctx := anAssoc presCtxAt: pdv presCtxId.
		fs := pdv fragment readStream.
		[ fs atEnd ] whileFalse: [ 
			element := DcElement from: fs explicitVR: ctx isExplicitVR.
			anAssoc addIncomingElement: element ].
		pdv isLast ifTrue: [ 
			msg := anAssoc lastElement.
			msg ifNotNil: [ 
				cmd := self class cmdAt: msg cmd.
				"convert message to req"
				param := DcSrvParam fromMessage: msg.
			anAssoc ae indication: cmd with: param for: anAssoc ] ] ]
]

{ #category : #helper }
DcDimse >> pdvsFromFrags: frags [

	| pdvs pdv bytes |
	pdvs := frags collect: [ :frag | 
		        bytes := ByteArray streamContents: [ :s |  
			                 frag do: [ :el | el writeOn: s ] ].
		        pdv := DcPDV new fragment: bytes.
		        pdv setCommand: frag first isCommandElement ].
	pdvs last setLast: true.
	^ pdvs
]

{ #category : #services }
DcDimse >> requestService: service param: param forAssoc: anAssoc [

	| msg els frags pdv1 pdvlist pdv2 |
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'request recieved.service: ' , service.
	anAssoc addOutstanding: param.
	msg := self messageForService: service param: param forAssoc: anAssoc.
	els := msg cmdElements.
	frags := self fragsFromElements: els.
	pdv1 := self pdvsFromFrags: frags.
	pdvlist := OrderedCollection with: pdv1.
	msg hasDataset ifTrue: [ 
		els := msg dataElements.
		frags := self fragsFromElements: els.
		pdv2 := self pdvsFromFrags: frags.
		pdvlist add: pdv2 ].
	pdvlist flattened do: [ :pdv | pdv presCtxId: msg ctxid ].
	"response is sent as pData _request_ to DUL"
	DcUpperLayerClient default request: pdvlist forAssoc: anAssoc
]

{ #category : #services }
DcDimse >> responseService: service param: param forAssoc: anAssoc [

	| msg els frags pdv1 pdvlist pdv2 | 
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, 'response recieved.service: ' , service.
	msg := self messageForService: service param: param forAssoc: anAssoc.
	els := msg cmdElements.
	frags := self fragsFromElements: els.
	pdv1 := self pdvsFromFrags: frags.
	pdvlist := OrderedCollection with: pdv1.
	msg hasDataset ifTrue: [ 
		els := msg dataElements.
		frags := self fragsFromElements: els.
		pdv2 := self pdvsFromFrags: frags.
		pdvlist add: pdv2 ].
	pdvlist flattened do: [ :pdv | pdv presCtxId: msg ctxid ].
	"response is sent as pData _request_ to DUL"
	DcUpperLayerClient default request: pdvlist forAssoc: anAssoc
]
