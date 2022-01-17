Class {
	#name : #DcAssociation,
	#superclass : #Object,
	#instVars : [
		'ae',
		'presCtxs',
		'dimse',
		'incomingMsg'
	],
	#category : #'CAs-DICOM-AE'
}

{ #category : #message }
DcAssociation >> addFragment: aFrag isCmd: isCmd [

	self deprecated: 'use messages'.
	"isCmd
		ifTrue: [ cmdFragments add: aFrag ]
		ifFalse: [ dataFragments add: aFrag ]"
]

{ #category : #message }
DcAssociation >> addIncomingElement: element [

	incomingMsg addElement: element
]

{ #category : #accessing }
DcAssociation >> ae [

	^ ae
]

{ #category : #accessing }
DcAssociation >> ae: anObject [

	ae := anObject
]

{ #category : #'accessing - deprecated' }
DcAssociation >> aet [
self deprecated:'not needed here'.
	"^ aet"
]

{ #category : #'accessing - deprecated' }
DcAssociation >> aet: anAET [
self deprecated:'not needed here'.
	"aet := anAET"
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

	self resetIncoming
]

{ #category : #'accessing - deprecated' }
DcAssociation >> ip: anIP [

	self deprecated: 'not needed here'.
	"ip := NetNameResolver addressForName: anIP timeout: 10"
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

{ #category : #message }
DcAssociation >> lastFragment [
	self deprecated: 'use messages'.

	self halt.
	self resetIncoming
]

{ #category : #'accessing - deprecated' }
DcAssociation >> port: aPort [

	self deprecated: 'not needed here'.
	"port := aPort"
]

{ #category : #accessing }
DcAssociation >> presCtxAt: aPresCtxID [


	| tsn |
	tsn:=(presCtxs at: aPresCtxID) second.
	^DcSyntax atUid: tsn value.
	
]

{ #category : #message }
DcAssociation >> resetIncoming [
incomingMsg := DcMessage new.
	"cmdFragments := OrderedCollection new.	dataFragments := OrderedCollection new."
]

{ #category : #accessing }
DcAssociation >> selectedPresCtxs: selectedPresCtx [

	presCtxs := Dictionary new.selectedPresCtx do:[:px|presCtxs  at: px ctxID  put: px items].
]
