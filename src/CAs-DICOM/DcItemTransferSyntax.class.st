Class {
	#name : #DcItemTransferSyntax,
	#superclass : #DcItemUid,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemTransferSyntax class >> default [

	^ self new value: '1.2.840.10008.1.2'
]

{ #category : #accessing }
DcItemTransferSyntax class >> itemType [

	^ Integer readFrom: '40H' base: 16
]

{ #category : #converting }
DcItemTransferSyntax >> asSyntax [

	^ DcSyntax atUid: value
]
