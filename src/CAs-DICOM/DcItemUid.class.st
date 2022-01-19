Class {
	#name : #DcItemUid,
	#superclass : #DcItemSimpleString,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #printing }
DcItemUid >> keyword [

	^DcTable uidAtCode: value.
]

{ #category : #printing }
DcItemUid >> printOn: stream [

	super printOn: stream.
	stream nextPut: $(.
	stream <<	self keyword.
	stream nextPut: $)
]
