"
A message has a commandset and sometimes a dataset. A commandset/dataset is a collection of elements.

The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5.

The encoding corresponds to the Implicit VR Data Element encoding defined in PS3.5.
"
Class {
	#name : #DcMessage,
	#superclass : #Object,
	#instVars : [
		'commandSet',
		'dataSet',
		'cmdDict'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommandElement
		ifTrue: [ commandSet add: anElement.cmdDict:=nil. ]
		ifFalse: [ dataSet add: anElement ]
]

{ #category : #accessing }
DcMessage >> cmd [

	^ self cmdDict at: 'CommandField'
]

{ #category : #adding }
DcMessage >> cmdDict [

	^ cmdDict ifNil: [ 
		  cmdDict := Dictionary new.
		  commandSet do: [ :c | cmdDict add: c assoc ] ]
]

{ #category : #adding }
DcMessage >> hasDataset [

	^dataSet isNotEmpty 
]

{ #category : #initialization }
DcMessage >> initialize [

	commandSet:=SortedCollection new.dataSet:=OrderedCollection new.
]

{ #category : #adding }
DcMessage >> requiresDataset [

	| noDataset |
	noDataset := Integer readFrom: '0101H' base: 16.
	^ (self cmdDict at: 'CommandDataSetType') ~= noDataset
]
