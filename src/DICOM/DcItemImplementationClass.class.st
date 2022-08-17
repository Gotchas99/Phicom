Class {
	#name : #DcItemImplementationClass,
	#superclass : #DcItemSimpleString,
	#category : #'DICOM-ACSE'
}

{ #category : #accessing }
DcItemImplementationClass class >> itemType [

	^ Integer readFrom: '52H' base: 16
]
