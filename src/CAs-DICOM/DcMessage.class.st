"
The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5.

The encoding corresponds to the Implicit VR Data Element encoding defined in PS3.5.
"
Class {
	#name : #DcMessage,
	#superclass : #Object,
	#instVars : [
		'presCtxId',
		'commandSet',
		'dataSet'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommandElement
		ifTrue: [ commandSet add: anElement ]
		ifFalse: [ dataSet add: anElement ]
]

{ #category : #adding }
DcMessage >> asDictionary [

	| d |
	d := Dictionary new.
	commandSet do: [ :c | d add: c assoc ].^d
]

{ #category : #accessing }
DcMessage >> cmd [

	self halt.
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
	self flag:'analyze command'
	.^false.

]
