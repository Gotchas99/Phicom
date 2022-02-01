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
		'dataDict',
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
DcMessage >> addCommand: aCmd value: aVal [

	cmdDict at: aCmd put: aVal.
	commandElements := SortedCollection new.
	
]

{ #category : #accessing }
DcMessage >> addCommandField: serviceName [

	| cmdCode |
	cmdCode := DcDimse cmdAtName: serviceName.
	self addCommand: #CommandField value: cmdCode 
]

{ #category : #accessing }
DcMessage >> addCommandGroupLength [

	"CommandGroupLength"

	| els len |
	els := self cmdElements.
	len := els inject: 0 into: [ :sum :each | sum + each groupLength ].
	self addCommand: 'CommandGroupLength' value: len
]

{ #category : #adding }
DcMessage >> addData: aKey value: aVal [

	dataDict at: aKey put: aVal.
	dataElements := SortedCollection new
]

{ #category : #accessing }
DcMessage >> addDataSetType [

	cmdDict at: #CommandDataSetType ifAbsentPut: self noDataset
]

{ #category : #adding }
DcMessage >> addElement: anElement [

	anElement isCommandElement
		ifTrue: [ 
			commandElements add: anElement.
			cmdDict := Dictionary new. ]
		ifFalse: [ dataElements add: anElement ]
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

{ #category : #converting }
DcMessage >> cmdElements [

| els el |
els:=SortedCollection new.
 cmdDict keysAndValuesDo:  [ :key :val|el:= DcElement new keyword: key value: val.els add:el].^els
]

{ #category : #converting }
DcMessage >> dataElements [

	| els el |
	els := SortedCollection new.
	dataDict keysAndValuesDo: [ :key :val | 
		el := DcElement new keyword: key value: val.
		els add: el ].
	^ els
]

{ #category : #adding }
DcMessage >> hasDataset [

	^dataElements isNotEmpty 
]

{ #category : #initialization }
DcMessage >> initialize [

	cmdDict := Dictionary new.dataDict := Dictionary new.
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

{ #category : #accessing }
DcMessage >> sopClassUid [

	^ self cmdDict at: 'AffectedSOPClassUID'
]
