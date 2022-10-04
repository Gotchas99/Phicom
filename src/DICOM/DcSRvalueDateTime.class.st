Class {
	#name : #DcSRvalueDateTime,
	#superclass : #DcSRvalueRel,
	#instVars : [
		'datetime'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueDateTime class >> valueType [

	^ 'DATETIME'
]

{ #category : #'instance creation' }
DcSRvalueDateTime >> from: elementList [

	super from: elementList.
	datetime := self at: 'DateTime' inList: elementList
]

{ #category : #printing }
DcSRvalueDateTime >> printOn: aStream [

	super printOn: aStream.
	aStream << '=' << datetime
]
