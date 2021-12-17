Class {
	#name : #DcAssociation,
	#superclass : #Object,
	#instVars : [
		'ae',
		'aet',
		'ip',
		'port',
		'sck',
		'rq',
		'presCtxs',
		'dimse',
		'cmdFragments',
		'dataFragments',
		'incomingMsg'
	],
	#category : #'CAs-DICOM-AE'
}

{ #category : #initialization }
DcAssociation >> addFragment: aFrag isCmd: isCmd [

	isCmd ifTrue:[cmdFragments add: aFrag] ifFalse:[dataFragments add: aFrag]
]

{ #category : #accessing }
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

{ #category : #accessing }
DcAssociation >> aet [

^	aet
]

{ #category : #accessing }
DcAssociation >> aet:anAET [
aet:=anAET
]

{ #category : #accessing }
DcAssociation >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAssociation >> dimse: anObject [

	dimse := anObject
]

{ #category : #ssl }
DcAssociation >> incomingMsg [
^incomingMsg ifNil:[incomingMsg:= DcMessage new.]
	
]

{ #category : #initialization }
DcAssociation >> initialize [
incomingMsg := DcMessage new.
	cmdFragments := OrderedCollection new.
	dataFragments := OrderedCollection new
]

{ #category : #accessing }
DcAssociation >> ip: anIP [

	ip :=NetNameResolver
		           addressForName:  anIP
		           timeout: 10.
]

{ #category : #initialization }
DcAssociation >> lastElement [

	self halt.
	self resetIncoming
]

{ #category : #initialization }
DcAssociation >> lastFragment [

	self halt.
self 	resetIncoming
]

{ #category : #accessing }
DcAssociation >> port:aPort [
port:=aPort
]

{ #category : #accessing }
DcAssociation >> presCtx: respPresCtx [

	presCtxs := Dictionary new.respPresCtx do:[:px|presCtxs  at: px ctxID  put: px items].
]

{ #category : #accessing }
DcAssociation >> presCtxAt: aPresCtxID [


	^presCtxs at: aPresCtxID 
]

{ #category : #ssl }
DcAssociation >> release [

	sck ifNotNil: [ sck close .sck:=nil]
]

{ #category : #initialization }
DcAssociation >> resetIncoming [


	cmdFragments := OrderedCollection new.
	dataFragments := OrderedCollection new
]

{ #category : #ssl }
DcAssociation >> rq:anAssociateRq [
rq:=anAssociateRq
]
