Class {
	#name : #DcItemImplementationClass,
	#superclass : #DcItemSimpleString,
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcItemImplementationClass class >> itemType [

	^ Integer readFrom: '52H' base: 16
]
