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
DcUpperLayerClient >> associateAET: anAET [ 

	^ DcAssociation new
		  aet: anAET
]

{ #category : #'as yet unclassified' }
DcUpperLayerClient >> request: pdvlist forAssoc: anAssoc [

	"expect: a list of PDV"

	| pdu |
	pdvlist flattened do: [ :pdv | 
		pdu := DcPDataTF new addItem: pdv.
		DcNet new sendPDU: pdu forAssoc: anAssoc ]
]
