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
DcDimse >> indication: aRequest forAssoc: anAssoc [

	
	self traceCr: 'PDV recieved'.self halt.
	^ nil
]
