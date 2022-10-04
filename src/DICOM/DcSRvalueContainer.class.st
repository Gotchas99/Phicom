Class {
	#name : #DcSRvalueContainer,
	#superclass : #DcContentItem,
	#instVars : [
		'content'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueContainer class >> valueType [
^'CONTAINER'
]

{ #category : #'instance creation' }
DcSRvalueContainer >> from: elementList [

	"ContentSequence = Tag(0040,a730)"

	| contentElements | 
	super from: elementList.
	contentElements := self at: 'ContentSequence' inList: elementList.
	content := contentElements collect: [ :el | DcContentItem from: el ]
]
