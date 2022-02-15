Class {
	#name : #DcUpperLayerClient,
	#superclass : #DcUpperLayer,
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #'as yet unclassified' }
DcUpperLayerClient >> associate: aReq forAssoc: anAssoc [

	"| pdu |
	pdu :=ByteArray streamContents: [:s|aReq writeOn: s]."

	| resp |
	resp := DcNet new sendAndRecievePDU: aReq forAssoc: anAssoc.^resp
]

{ #category : #'as yet unclassified' }
DcUpperLayerClient >> request: pdvlist forAssoc: anAssoc [

	"expect: a list of PDV"

	| pdu |
	pdvlist flattened do: [ :pdv | 
		pdu := DcPDataTF new addItem: pdv.
		DcNet new sendPDU: pdu forAssoc: anAssoc ]
]
