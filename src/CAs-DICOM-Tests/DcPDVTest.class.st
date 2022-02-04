"
A DcPDVTest is a test class for testing the behavior of DcPDV
"
Class {
	#name : #DcPDVTest,
	#superclass : #TestCase,
	#category : #'CAs-DICOM-Tests-UpperLayer'
}

{ #category : #tests }
DcPDVTest >> testInputPdv [

	"PDV-lista utan pdata-tf-header
format är:
length: 4 bytes big endian 
presCtxID: 1 byte
---
header 1 byte
fragment (dvs lista ev element) resten <length> bytes"

	| bytes len |
	bytes := #( 0 0 0 70 1 3 0 0 0 0 4 0 0 0 56 0 0 0 0 0 2 0 18 0 0 0 49
	            46 50 46 56 52 48 46 49 48 48 48 56 46 49 46 49 0 0 0 0 1
	            2 0 0 0 48 0 0 0 16 1 2 0 0 0 2 0 0 0 0 8 2 0 0 0 1 1 ).len:= bytes size.
]

{ #category : #tests }
DcPDVTest >> testOutputPdv [

	| bytes len |
	bytes := #( 0 0 0 0 4 0 0 0 66 0 0 0 2 0 0 0 18 0 0 0 49 46 50 46 56
	            52 48 46 49 48 48 48 56 46 49 46 49 0 0 1 0 0 2 0 0 0 48
	            128 32 1 0 0 2 0 0 0 2 0 0 8 0 0 2 0 0 0 1 1 0 9 0 0 2 0
	            0 0 0 0 ).len := bytes size
]
