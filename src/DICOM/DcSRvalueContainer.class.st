Class {
	#name : #DcSRvalueContainer,
	#superclass : #DcContentItem,
	#instVars : [
		'content',
		'template'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueContainer class >> valueType [
^'CONTAINER'
]

{ #category : #accessing }
DcSRvalueContainer >> children [

	^ content select: [ :each | each isContainer ]
]

{ #category : #'instance creation' }
DcSRvalueContainer >> content [
^content
]

{ #category : #'instance creation' }
DcSRvalueContainer >> from: elementList [

	"ContentSequence = Tag(0040,a730)"

	| contentElements |
	super from: elementList.
	contentElements := self at: 'ContentSequence' inList: elementList.
	content := contentElements collect: [ :el | DcContentItem from: el ].
	self readTemplateFrom: elementList
]

{ #category : #testing }
DcSRvalueContainer >> isContainer [

	^ true
]

{ #category : #printing }
DcSRvalueContainer >> printOn: aStream [

	aStream << valueType << ':' << conceptName meaning 
]

{ #category : #'instance creation' }
DcSRvalueContainer >> readTemplateFrom: elementList [

	| tempElements |
	[ 
	tempElements := self
		                at: 'ContentTemplateSequence'
		                inList: elementList ]
		on: Error 
		do: [ :ex | "ignore missing template" ^ self ].
	template := self at: 'TemplateIdentifier' inList: tempElements first
]

{ #category : #accessing }
DcSRvalueContainer >> values [

	^content select:[:each|each isSimple ]
]
