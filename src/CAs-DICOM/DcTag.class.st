Class {
	#name : #DcTag,
	#superclass : #Object,
	#instVars : [
		'bin'
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
	g := s nextLittleEndianNumber: 2.	e := s nextLittleEndianNumber: 2.bin:= g<<16+e
]

{ #category : #'instance creation' }
DcTag >> fromString: s [

	 self parseHexTag: s
]

{ #category : #printing }
DcTag >> keyword [

	^ [(DcTable in: #table_6_1 atBin: bin)
		  at: #Keyword
		  ifAbsent: [ '???' ]]onErrorDo:['***']
]

{ #category : #'as yet unclassified' }
DcTag >> parseHex: aHexString [
^ 
	aHexString
		inject: 0
		into: [ :sum :each | sum * 16 + each hexDigitValue ]
]

{ #category : #'as yet unclassified' }
DcTag >> parseHexTag: tag [

	| tmp1 |
	tmp1 := tag copyWithoutAll: ',()'.
	 bin := [self parseHex: tmp1 ]
		onErrorDo: [ 0 ].
	^ bin
]

{ #category : #printing }
DcTag >> printOn: aStream [

	| bytes |
	"	super printOn: aStream."
	bytes := (bin asByteArrayOfSize: 4) hex.
	aStream << $( << (bytes first: 4) << $, << (bytes last: 4) << $)
	<< $  << self keyword
]
