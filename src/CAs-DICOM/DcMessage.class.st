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
		'dataElements',
		'dataDict'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'instance creation' }
DcMessage class >> fromParam: param [

	^self new param: param
]

{ #category : #adding }
DcMessage >> addCommand: aCmd value: aVal [

	
	cmdDict at: aCmd put: aVal.commandElements := nil.
]

{ #category : #accessing }
DcMessage >> addCommandField: serviceName [

	| cmdCode |
	cmdCode := DcDimse cmdAtName: serviceName.
	self addCommand: #CommandField value: cmdCode 
]

{ #category : #accessing }
DcMessage >> addCommandGroupLength [

	
]

{ #category : #accessing }
DcMessage >> addDataSetType [

	cmdDict at: #CommandDataSetType ifAbsentPut: self noDataset
]

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommandElement
		ifTrue: [ commandElements add: anElement.cmdDict:=nil. ]
		ifFalse: [ dataElements add: anElement ]
]

{ #category : #converting }
DcMessage >> asElements [
]

{ #category : #accessing }
DcMessage >> cmd [

	^ self cmdDict at: 'CommandField'
]

{ #category : #adding }
DcMessage >> cmdDict [

	^ cmdDict ifEmpty: [  
		  cmdDict := Dictionary new.
		  commandElements do: [ :el | cmdDict add: el assoc ].
		  cmdDict ]
]

{ #category : #adding }
DcMessage >> hasDataset [

	^dataElements isNotEmpty 
]

{ #category : #initialization }
DcMessage >> initialize [
cmdDict:=Dictionary new.
	commandElements := SortedCollection new.
	dataElements := OrderedCollection new
]

{ #category : #accessing }
DcMessage >> noDataset [

	^ Integer readFrom: '0101H' base: 16 
]

{ #category : #accessing }
DcMessage >> param: param [

	self halt.
]

{ #category : #adding }
DcMessage >> requiresDataset [

	^ (self cmdDict at: 'CommandDataSetType') ~= self noDataset
]
