Class {
	#name : #DcDimse,
	#superclass : #Object,
	#instVars : [
		'ae'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #accessing }
DcDimse >> ae: anAE [

	| dul |
	ae := anAE.
	dul := DcUpperLayerServer default.
	dul registerDimse: self for: ae aeTitle
]

{ #category : #'as yet unclassified' }
DcDimse >> cEcho:param [
]

{ #category : #'as yet unclassified' }
DcDimse >> indicationService: service param: param forAssoc: anAssoc [

	| resp |
	self traceCr: 'DIMSE.indication recieved.service: ' , service.

	#pData = service ifTrue: [ 
				self pData: param forAssoc: anAssoc .resp := nil.].

	^ resp
]

{ #category : #'as yet unclassified' }
DcDimse >> pData: pdvList forAssoc: anAssoc [

	| element fs ctx |
	self flag: 'hur hittar man exp/imp VR'.
	pdvList do: [ :pdv | 
		ctx := anAssoc presCtxAt: pdv presCtxId.
		fs := pdv fragment readStream.
		[ fs atEnd ] whileFalse: [ 
			element := DcElement from: fs explicitVR: false.
			anAssoc addIncomingElement: element ].
		"anAssoc addFragment: pdv fragment isCmd: pdv isCommand."
		self halt.
		pdv isLast ifTrue: [ anAssoc  lastElement "lastFragment" ] ]
]
