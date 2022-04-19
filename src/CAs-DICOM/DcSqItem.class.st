Class {
	#name : #DcSqItem,
	#superclass : #Object,
	#instVars : [
		'elements',
		'tag',
		'length'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'instance creation' }
DcSqItem class >> from: s explicitVR: aBoolean [

	^ self new from: s explicitVR: aBoolean
]

{ #category : #'instance creation' }
DcSqItem >> elements [
^elements
]

{ #category : #'instance creation' }
DcSqItem >> from: s explicitVR: aBoolean [

	| el dict endOflist |
	tag := DcTag from: s.
	length := s nextLittleEndianNumber: 4.
	elements := OrderedCollection new.
	endOflist := s atEnd or:[tag isSeqDelimiter ].
	[ endOflist ] whileFalse: [ 
		el := DcElement from: s explicitVR: aBoolean.
		el isItemDelimiter
			ifTrue: [ endOflist := true ]
			ifFalse: [ 
				elements add: el.
				endOflist := s atEnd ] ].
	dict := (elements collect: #assoc) asDictionary.
	^ dict
]

{ #category : #testing }
DcSqItem >> isItemDelimiter [

	
]

{ #category : #testing }
DcSqItem >> isSeqDelimiter [
]

{ #category : #testing }
DcSqItem >> isUndefined [

	"Undefined Length = FFFFFFFFH"

	^ length = 4294967295
]
