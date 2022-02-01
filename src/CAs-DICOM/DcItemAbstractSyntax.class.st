Class {
	#name : #DcItemAbstractSyntax,
	#superclass : #DcItemUid,
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

{ #category : #converting }
DcItemAbstractSyntax >> asSyntax [

	^DcSyntax atUid: value
]
