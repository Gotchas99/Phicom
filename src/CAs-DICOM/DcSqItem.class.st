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

	| el dict |
	tag := DcTag from: s.
	length := s nextLittleEndianNumber: 4.
	elements := OrderedCollection new.
	[ s atEnd ] whileFalse: [ 
		el := DcElement from: s explicitVR: aBoolean.
		elements add: el ].
	dict := (elements collect: #assoc) asDictionary.
	^ dict
]

{ #category : #testing }
DcSqItem >> isUndefined [

	"Undefined Length = FFFFFFFFH"

	^ length = 4294967295
]
