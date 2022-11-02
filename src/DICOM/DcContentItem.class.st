"
Each Content Item contains:
name/value pair, consisting of
a single Concept Name Code Sequence (0040,A043) that is the name of a name/value pair or a heading,
a value (text, codes, etc.),
references to images, waveforms or other composite objects, with or without coordinates,
relationships to other Items, either
by-value through nested Content Sequences, or
by-reference.

https://dicom.nema.org/medical/dicom/2018b/output/chtml/part03/sect_C.17.3.2.html#table_C.17.3-7
"
Class {
	#name : #DcContentItem,
	#superclass : #Object,
	#instVars : [
		'valueType',
		'conceptName'
	],
	#category : #'DICOM-SR'
}

{ #category : #accessing }
DcContentItem class >> at: aKey inList: elements [

	^ elements isDictionary
		  ifTrue: [ elements at:aKey ifAbsent: [ Error signal: 'element key not found' ]]
		  ifFalse: [ 
			  elements
				  detect: [ :el | el keyword = aKey ]
				  ifFound: [ :el | el value ]
				  ifNone: [ Error signal: 'element key not found' ] ]
]

{ #category : #'instance creation' }
DcContentItem class >> from: elementList [

	"	^ self new from: elementList"

	| valueType valueClass |
	valueType := self at: 'ValueType' inList: elementList.
	valueClass := self allSubclasses detect: [ :sc | 
		              sc valueType = valueType ].
	^ valueClass new from: elementList
]

{ #category : #accessing }
DcContentItem class >> valueType [ ^'Not implemented'
]

{ #category : #accessing }
DcContentItem >> at: aKey inList: elements [
^self class at: aKey inList: elements
]

{ #category : #printing }
DcContentItem >> conceptName [

^conceptName 

	
]

{ #category : #'instance creation' }
DcContentItem >> from: elementList [

	valueType := self at: 'ValueType' inList: elementList.
	conceptName := DcTriplet fromSeq:
		               (self
			                at: 'ConceptNameCodeSequence'
			                inList: elementList).

]

{ #category : #testing }
DcContentItem >> isContainer [
^false
]

{ #category : #testing }
DcContentItem >> isSimple [
	^ self isContainer not
]

{ #category : #printing }
DcContentItem >> printOn: aStream [

	aStream "<< valueType << ':'" << conceptName meaning
]

{ #category : #printing }
DcContentItem >> valueString [

	^'???'
]
