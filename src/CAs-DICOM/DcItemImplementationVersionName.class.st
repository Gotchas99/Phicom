Class {
	#name : #DcItemImplementationVersionName,
	#superclass : #DcItemSimpleString,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemImplementationVersionName class >> itemType [

	^ Integer readFrom: '55H' base: 16
]
