Class {
	#name : #DcItemUid,
	#superclass : #DcItemSimpleString,
	#category : #'DICOM-ACSE'
}

{ #category : #printing }
DcItemUid >> fromKeyword: aString [

	value := DcTable uidAtKeyword:  aString
]

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
