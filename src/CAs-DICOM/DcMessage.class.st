"
The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5.

The encoding corresponds to the Implicit VR Data Element encoding defined in PS3.5.
"
Class {
	#name : #DcMessage,
	#superclass : #Object,
	#instVars : [
		'commandSet',
		'dataSet'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommand
		ifTrue: [ commandSet add: anElement ]
		ifFalse: [ dataSet add: anElement ]
]

{ #category : #initialization }
DcMessage >> initialize [

	commandSet:=SortedCollection new.dataSet:=OrderedCollection new.
]
