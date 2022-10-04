Class {
	#name : #DcSRvalueRel,
	#superclass : #DcContentItem,
	#instVars : [
		'relationship'
	],
	#category : #'DICOM-SR'
}

{ #category : #'instance creation' }
DcSRvalueRel >> from: elementList [

	super from: elementList.
	relationship := self at: 'RelationshipType' inList: elementList
]

{ #category : #printing }
DcSRvalueRel >> printOn: aStream [

	aStream "<< valueType << ':' "<< relationship << ':'
	<< conceptName meaning
]
