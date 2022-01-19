"
Part of an element in the tag-(VR)-length-value structure
"
Class {
	#name : #DcTag,
	#superclass : #Object,
	#instVars : [
		'bin',
		'hex'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'instance creation' }
DcTag class >> from:s [
^self new from:s
]

{ #category : #'instance creation' }
DcTag class >> fromString: s [

	^ self new fromString: s
]

{ #category : #comparing }
DcTag >> <= otherTag [

	^bin <= otherTag bin
]

{ #category : #accessing }
DcTag >> bin [
^bin
]

{ #category : #'instance creation' }
DcTag >> from: s [

	| g e |
	g := (s next: 2) unsignedShortAt: 1 bigEndian: false.
	e := (s next: 2) unsignedShortAt: 1 bigEndian: false.
	bin := g << 16 + e
]

{ #category : #'instance creation' }
DcTag >> fromString: s [

	 self parseHexTag: s
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

{ #category : #printing }
DcTag >> keyword [

	^ [ 
	  (DcTable tagAt: bin)
		  at: #Keyword
		  ifAbsent: [ '???' ] ] onErrorDo: [ '***' ]
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

	| tmp1 |
	hex := tag.
	tmp1 := tag copyWithoutAll: ',()'.
	bin := [ self parseHex: tmp1 ] onErrorDo: [ 0 ].
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

	^ [ (DcTable tagAt: bin) at: #VR ifAbsent: [ '???' ] ] 
		  onErrorDo: [ '***' ]
]
