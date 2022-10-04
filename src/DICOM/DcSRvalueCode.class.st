Class {
	#name : #DcSRvalueCode,
	#superclass : #DcContentItem,
	#instVars : [
		'conceptCode'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueCode class >> valueType [

	^ 'CODE'
]

{ #category : #'instance creation' }
DcSRvalueCode >> from: elementList [

	super from: elementList.
	conceptCode := 
	               DcTriplet fromSeq:
		               (self at: 'ConceptCodeSequence' inList: elementList) 
]

{ #category : #printing }
DcSRvalueCode >> printOn: aStream [

	super printOn: aStream.
	aStream << ':' << conceptCode meaning
]
