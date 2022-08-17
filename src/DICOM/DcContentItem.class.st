Class {
	#name : #DcContentItem,
	#superclass : #Object,
	#instVars : [
		'valueType',
		'conceptName',
		'conceptCode',
		'value'
	],
	#category : #'DICOM-SR'
}

{ #category : #'instance creation' }
DcContentItem class >> from: elementList [

	^self new from:elementList
]

{ #category : #accessing }
DcContentItem >> at:aKey inList:elements [
^ elements
		  detect: [ :el | el keyword = aKey ]
		  ifFound: [ :el | el value ]
		  ifNone: [ Error signal: 'element key not found' ]
]

{ #category : #'instance creation' }
DcContentItem >> from:elementList [
valueType := self at:'ValueType' inList:elementList.
conceptName:= DcTriplet fromSeq:(self at:'ConceptNameCodeSequence' inList:elementList).
]

{ #category : #printing }
DcContentItem >> printOn: aStream [

	aStream << valueType << ':' << conceptName meaning
]
