Class {
	#name : #DcAssociation,
	#superclass : #Object,
	#instVars : [
		'ae',
		'remoteAETitle',
		'dimse',
		'incomingMsg',
		'stream',
		'ctxID',
		'offeredPresCtxs',
		'agreedPresCtxs',
		'lastKnownMsgId',
		'outstanding'
	],
	#category : #'CAs-DICOM-AE'
}

{ #category : #message }
DcAssociation >> addIncomingElement: element [

	incomingMsg addElement: element
]

{ #category : #'presentation context' }
DcAssociation >> addOfferedPresCtxs: asn tsn: tsn [

	| sn |
	sn := (OrderedCollection with:asn)  , tsn.
	offeredPresCtxs at: self nextCtxID put: sn
]

{ #category : #accessing }
DcAssociation >> addOutstanding: aMsg [

	^ outstanding at: aMsg messageId  put: aMsg
]

{ #category : #accessing }
DcAssociation >> ae [

	^ ae
]

{ #category : #accessing }
DcAssociation >> ae: anObject [

	ae := anObject
]

{ #category : #'presentation context' }
DcAssociation >> agreedPresCtxs: acceptedPresCtx [

	| asn sn tsn |
	agreedPresCtxs := Dictionary new.
	acceptedPresCtx do: [ :px | 
		asn:= (offeredPresCtxs at:px ctxID)first.
		tsn:= DcTable uidAtCode:(px items first value).
		sn:= OrderedCollection with:asn with:tsn.
		agreedPresCtxs at: px ctxID put: sn ]
]

{ #category : #'presentation context' }
DcAssociation >> asnForService: aService [
]

{ #category : #'presentation context' }
DcAssociation >> ctxidForSopUid: anAbstractSyntaxUID [

	| asn |
	asn := DcTable uidAtCode: anAbstractSyntaxUID.
	agreedPresCtxs keysAndValuesDo: [ :key :value | 
		value first value = asn ifTrue: [ ^ key ] ].
	Error signal: 'ctxId not found'
]

{ #category : #accessing }
DcAssociation >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAssociation >> dimse: anObject [

	dimse := anObject
]

{ #category : #initialization }
DcAssociation >> initialize [

	self resetIncoming.
	remoteAETitle:='<UNKNOWN AE>'.
	offeredPresCtxs := Dictionary new.
	agreedPresCtxs := Dictionary new.
	lastKnownMsgId := 0.
	outstanding := Dictionary new
]

{ #category : #testing }
DcAssociation >> isEmpty [

	^ outstanding isEmpty 
]

{ #category : #message }
DcAssociation >> lastElement [

	| tmp |
	incomingMsg requiresDataset ifTrue: [ 
		incomingMsg hasDataset ifFalse: [ ^ nil ] ].
	tmp := incomingMsg .
		self resetIncoming.
	^ tmp
]

{ #category : #accessing }
DcAssociation >> lastKnownMsgId: anInt [

	anInt ifNotNil:[lastKnownMsgId := lastKnownMsgId max: anInt]
]

{ #category : #accessing }
DcAssociation >> nextCtxID [

	^ ctxID := ctxID ifNil: [ 1 ] ifNotNil: [ ctxID + 2 ]
]

{ #category : #accessing }
DcAssociation >> nextMsgId [
lastKnownMsgId:=lastKnownMsgId+1.
^lastKnownMsgId
]

{ #category : #'presentation context' }
DcAssociation >> offeredPresCtxs [
^
	offeredPresCtxs
]

{ #category : #'presentation context' }
DcAssociation >> offeredPresCtxs: pctxs [
offeredPresCtxs:= pctxs
]

{ #category : #'presentation context' }
DcAssociation >> presCtxAt: aPresCtxID [


	| tsn |
	tsn:=(agreedPresCtxs at: aPresCtxID) second.
	^DcSyntax atName: tsn .
	
]

{ #category : #'presentation context' }
DcAssociation >> presForAsn: anAbstractSyntax [

	| tsn |
	tsn := (agreedPresCtxs at: anAbstractSyntax) second.
	^ DcSyntax atUid: tsn value
]

{ #category : #accessing }
DcAssociation >> receiveOutstandingID: aMsgId [

	| msg |
	msg := outstanding
		       at: aMsgId
		       ifAbsent: [ Error signal: 'outstanding message not found' ].
		outstanding removeKey: aMsgId .^msg
]

{ #category : #accessing }
DcAssociation >> release [ 	self ae releaseAssoc: self
]

{ #category : #accessing }
DcAssociation >> remoteAETitle [
^remoteAETitle
]

{ #category : #accessing }
DcAssociation >> remoteAETitle: aString [

	 remoteAETitle:= aString
]

{ #category : #initialization }
DcAssociation >> reset [

	ae :=  dimse:= incomingMsg:= stream:= offeredPresCtxs:= agreedPresCtxs:=nil
]

{ #category : #message }
DcAssociation >> resetIncoming [
incomingMsg := DcMessage new.
	"cmdFragments := OrderedCollection new.	dataFragments := OrderedCollection new."
]

{ #category : #'presentation context' }
DcAssociation >> selectedPresCtxs: selectedPresCtx [

	agreedPresCtxs := Dictionary new.
	selectedPresCtx do: [ :px | 
		agreedPresCtxs at: px ctxID put: (px items collect:[:it|it asSyntax name]) ]
]

{ #category : #accessing }
DcAssociation >> stream [

	^ stream
]

{ #category : #accessing }
DcAssociation >> stream: anObject [

	stream := anObject
]
