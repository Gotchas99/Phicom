Class {
	#name : #DcItemPresContextAc,
	#superclass : #DcItemPresContext,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemPresContextAc class >> itemType [

	^ Integer readFrom: '21H' base: 16
]
