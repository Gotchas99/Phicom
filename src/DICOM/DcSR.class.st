Class {
	#name : #DcSR,
	#superclass : #DcSRvalueContainer,
	#instVars : [
		'type'
	],
	#category : #'DICOM-SR'
}

{ #category : #'instance creation' }
DcSR >> from: elementList [

	super from: elementList.
	type := self conceptName meaning
]

{ #category : #printing }
DcSR >> printOn: aStream [

	aStream << 'SR' << '(' << 'codeValue' << ')'
]
