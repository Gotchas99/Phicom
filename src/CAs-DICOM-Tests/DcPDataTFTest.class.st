"
A DcPDataTFTest is a test class for testing the behavior of DcPDataTF
"
Class {
	#name : #DcPDataTFTest,
	#superclass : #TestCase,
	#category : #'CAs-DICOM-Tests-Net'
}

{ #category : #'as yet unclassified' }
DcPDataTFTest >> testOutputPdataTF [

	"big endian"

	| bytes len |
	"P-DATA-TF är :
	type: 1 byte
	skip 1 byte
	length 4 byte (big endian)
	resten är PDV-lista
	dvs header är 6 bytes
	"
	bytes := #(  ).
	len := bytes size
]

{ #category : #'as yet unclassified' }
DcPDataTFTest >> testinputPdataTF [

	"big endian"

	| bytes |
	"P-DATA-TF är :
	type: 1 byte
	skip 1 byte
	length 4 byte (big endian)
	resten är PDV-lista
	dvs header är 6 bytes
	"
	bytes := #( 4 0 0 0 0 74 0 0 0 70 1 3 0 0 0 0 4 0 0 0 56 0 0 0 0 0 2
	            0 18 0 0 0 49 46 50 46 56 52 48 46 49 48 48 48 56 46 49
	            46 49 0 0 0 0 1 2 0 0 0 48 0 0 0 16 1 2 0 0 0 2 0 0 0 0 8
	            2 0 0 0 1 1 )
]
