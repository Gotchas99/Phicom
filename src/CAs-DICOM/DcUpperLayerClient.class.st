Class {
	#name : #DcUpperLayerClient,
	#superclass : #DcUpperLayer,
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #converting }
DcUpperLayerClient >> associate: anAssoc [

	self halt.
]

{ #category : #'as yet unclassified' }
DcUpperLayerClient >> request: pdu forAssoc: anAssoc [
"expect: a list of PDV"
	| response service |
	self flag: 'not done'.self halt.
	
]
