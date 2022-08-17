Class {
	#name : #DcItem,
	#superclass : #Object,
	#instVars : [
		'items',
		'itemType',
		'lengthField'
	],
	#classVars : [
		'TypeMap'
	],
	#category : #'DICOM-ACSE'
}

{ #category : #initialization }
DcItem class >> initialize [

	self initializeTypeMap
]

{ #category : #initialization }
DcItem class >> initializeTypeMap [

	TypeMap := Dictionary new.
	self allSubclassesDo: [ :c| 	TypeMap at: c itemType put: c]

]

{ #category : #accessing }
DcItem class >> itemType [
^-1
]

{ #category : #'instance creation' }
DcItem class >> readFrom: aSocketStream [

	| type itemClass
	 |
	type := aSocketStream peek.
	itemClass := TypeMap at: type.
	^ itemClass new readFrom: aSocketStream
]

{ #category : #comparing }
DcItem >> <= otherItem [

	^self itemType <= otherItem itemType
]

{ #category : #validating }
DcItem >> checkLength [

	| buffstream b |
	items do:[:each|each checkLength ].
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     self writeOn: buffstream.
		     buffstream close ].

	b size = self extLength ifFalse: [ self halt ]
]

{ #category : #writing }
DcItem >> extLength [

	^ self headerLength + self lengthField
]

{ #category : #writing }
DcItem >> headerLength [

	^ 1 + 1 + 2
]

{ #category : #initialization }
DcItem >> initialize [

	"items := OrderedCollection new"
	items := SortedCollection new
]

{ #category : #printing }
DcItem >> itemName [

	^(self className ) allButFirst:6.
]

{ #category : #accessing }
DcItem >> itemType [

	^ itemType ifNil: [ itemType := self class itemType ]
]

{ #category : #accessing }
DcItem >> items [ 
^items
]

{ #category : #accessing }
DcItem >> lengthField [

	^ self myLength
	  + (items sum: [ :each | each extLength ])
]

{ #category : #accessing }
DcItem >> myLength [

	^ 0
]

{ #category : #printing }
DcItem >> printOn: stream [

 stream nextPutAll: 	self itemName 
	"stream nextPut: $(."

	"stream nextPut: $)" "self itemName."
]

{ #category : #'instance creation' }
DcItem >> readFrom: stream [

	| length pduStream |
	itemType := stream next.
	stream skip: 1.
	length := (stream next: 2) unsignedShortAt: 1 bigEndian: true.pduStream := DcLimitedReadStream on: stream length: length.
	self readItemFrom: pduStream
]

{ #category : #'instance creation' }
DcItem >> readItemFrom: stream [
self subclassResponsibility 
]

{ #category : #initialization }
DcItem >> replaceItems: newItems [



	items := newItems
]

{ #category : #writing }
DcItem >> writeOn: stream [

	
	stream
		uint8: self itemType;
		uint8: 0;
		uint16: self lengthField
]
