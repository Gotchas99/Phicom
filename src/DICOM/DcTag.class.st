"
Part of an element in the tag-(VR)-length-value structure
"
Class {
	#name : #DcTag,
	#superclass : #Object,
	#instVars : [
		'bin',
		'hex',
		'keyword',
		'vr'
	],
	#category : #'DICOM-Core'
}

{ #category : #'instance creation' }
DcTag class >> from:s [
^self new from:s
]

{ #category : #'instance creation' }
DcTag class >> fromKeyword: aKeyword [

	^ self new fromKeyword: aKeyword 
]

{ #category : #'instance creation' }
DcTag class >> fromString: s [

	^ self new fromString: s
]

{ #category : #comparing }
DcTag >> <= otherTag [

	^bin <= otherTag bin
]

{ #category : #comparing }
DcTag >> = aTag [

	aTag class = self class ifFalse: [ ^ false ].
	^bin=aTag bin
]

{ #category : #accessing }
DcTag >> bin [
^bin
]

{ #category : #'instance creation' }
DcTag >> bin: aBinTagCode [

	bin := aBinTagCode.
	keyword := nil.
	vr := nil.
	hex := nil
]

{ #category : #'instance creation' }
DcTag >> from: s [

	| g e |
	g := (s next: 2) unsignedShortAt: 1 bigEndian: false.
	e := (s next: 2) unsignedShortAt: 1 bigEndian: false.
self 	bin: g << 16 + e
]

{ #category : #'instance creation' }
DcTag >> fromKeyword: aKeyword [

	self bin: ( (DcTable tagAt: aKeyword )at: 'TagHex')
]

{ #category : #'instance creation' }
DcTag >> fromString: s [

	 self parseHexTag: s
]

{ #category : #writing }
DcTag >> group [

	^
	 bin bitShift: -16.

]

{ #category : #comparing }
DcTag >> hash [

	^bin
]

{ #category : #printing }
DcTag >> hex [

	| bytes |
	^hex ifNil: [ 
		bytes := (bin asByteArrayOfSize: 4) hex.
		hex := '(' , (bytes first: 4) , ',' , (bytes last: 4) , ')' ]
]

{ #category : #testing }
DcTag >> isCommand [
^bin <= (self parseHex:'FFFF')
	
]

{ #category : #testing }
DcTag >> isItemDelimiter [

	"(FFFE,E00D) = ItemDelimitationItem"

	^bin=4294893581
]

{ #category : #testing }
DcTag >> isKeyword: aKeyword [

	^keyword=aKeyword  
]

{ #category : #writing }
DcTag >> isPrivate [
^ self group odd

]

{ #category : #testing }
DcTag >> isSeqDelimiter [

	"(FFFE,E0DD) = SequenceDelimitationItem"

	^bin=4294893789
]

{ #category : #printing }
DcTag >> keyword [

	^ keyword ifNil: [ 
		  keyword := [ 
		             self isPrivate
			             ifTrue: [ 'Private tag' ]
			             ifFalse: [ 
			             (DcTable tagAt: bin) at: #Keyword ifAbsent: [ '???' ] ] ] 
			             onErrorDo: [ '***' ] ]
]

{ #category : #'instance creation' }
DcTag >> parseHex: aHexString [
^ 
	aHexString
		inject: 0
		into: [ :sum :each | sum * 16 + each hexDigitValue ]
]

{ #category : #'instance creation' }
DcTag >> parseHexTag: tag [

	| digits |
	hex := tag.
	digits := hex copyWithoutAll: ',()'.
	self bin: ([ self parseHex: digits ] onErrorDo: [ 0 ]).
	^ bin
]

{ #category : #printing }
DcTag >> printOn: aStream [

	aStream << 'Tag'.
	aStream << self hex
	"bin ifNotNil: [ 
		bytes := (bin asByteArrayOfSize: 4) hex.
		aStream << $( << (bytes first: 4) << $, << (bytes last: 4) << $) ]"
	"aStream << $  << self keyword"
]

{ #category : #printing }
DcTag >> vr [

	^ vr ifNil:[vr:=[ (DcTable tagAt: bin) at: #VR ifAbsent: [ '???' ] ] onErrorDo: [ 
		  '***' ]]
]

{ #category : #writing }
DcTag >> writeOn: s [

	| group element |
	group := bin bitShift: -16. 
	element := 65535 bitAnd: bin.
	s nextLittleEndianNumber: 2 put: group.
	s nextLittleEndianNumber: 2 put: element
]
