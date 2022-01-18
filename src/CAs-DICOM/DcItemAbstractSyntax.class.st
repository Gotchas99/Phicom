Class {
	#name : #DcItemAbstractSyntax,
	#superclass : #DcItemSimpleString,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemAbstractSyntax class >> itemType [

	^ Integer readFrom: '30H' base: 16
]

{ #category : #'as yet unclassified' }
DcItemAbstractSyntax class >> verification [

	^ self new value: '1.2.840.10008.1.1'
]