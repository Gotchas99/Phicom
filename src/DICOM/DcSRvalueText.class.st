Class {
	#name : #DcSRvalueText,
	#superclass : #DcSRvalueRel,
	#instVars : [
		'text'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueText class >> valueType [

	^ 'TEXT'
]

{ #category : #'instance creation' }
DcSRvalueText >> from: elementList [

	super from: elementList.
	text := self at: 'TextValue' inList: elementList
]

{ #category : #printing }
DcSRvalueText >> printOn: aStream [

	super printOn: aStream.
	aStream << '=' << text
]
