"
A message has a commandset and sometimes a dataset. A commandset/dataset is a collection of elements.

The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5.

The encoding corresponds to the Implicit VR Data Element encoding defined in PS3.5.
"
Class {
	#name : #DcMessage,
	#superclass : #Object,
	#instVars : [
		'cmdDict',
		'commandElements',
		'dataElements'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'instance creation' }
DcMessage class >> fromParam: param [

	^self new param: param
]

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommandElement
		ifTrue: [ commandElements add: anElement.cmdDict:=nil. ]
		ifFalse: [ dataElements add: anElement ]
]

{ #category : #accessing }
DcMessage >> cmd [

	^ self cmdDict at: 'CommandField'
]

{ #category : #adding }
DcMessage >> cmdDict [

	^ cmdDict ifNil: [ 
		  cmdDict := Dictionary new.
		  commandElements do: [ :c | cmdDict add: c assoc ] .cmdDict]
]

{ #category : #adding }
DcMessage >> hasDataset [

	^dataElements isNotEmpty 
]

{ #category : #initialization }
DcMessage >> initialize [

	commandElements:=SortedCollection new.dataElements:=OrderedCollection new.
]

{ #category : #'as yet unclassified' }
DcMessage >> param: param [

	self halt.
]

{ #category : #adding }
DcMessage >> requiresDataset [

	| noDataset |
	noDataset := Integer readFrom: '0101H' base: 16.
	^ (self cmdDict at: 'CommandDataSetType') ~= noDataset
]
