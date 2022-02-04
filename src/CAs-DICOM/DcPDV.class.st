"
https://dicom.nema.org/medical/dicom/current/output/html/part08.html#chapter_E

A PDV User Data parameter shall contain one and only one fragment (either Command or Data) preceded by a Message Control Header.

Each PDV shall consist of two parameters: a Presentation Context ID and User Data values
"
Class {
	#name : #DcPDV,
	#superclass : #Object,
	#instVars : [
		'header',
		'presCtxId',
		'fragment',
		'elements'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #'instance creation' }
DcPDV class >> readFrom: stream [

	
	^ self  new readFrom: stream
]

{ #category : #writing }
DcPDV >> asByteArray [

	| tmp |
	tmp := ByteArray streamContents: [ :s | self writeOn: s ].
	^ tmp
]

{ #category : #validating }
DcPDV >> checkLength [

	| buffstream b |
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     self writeOn: buffstream.
		     buffstream close ].

	b size = self extLength ifFalse: [ self halt ].
	self traceCr: self class name , ' ' , 'checkLength passed'
]

{ #category : #accessing }
DcPDV >> elements: aListOfElements [
elements:=aListOfElements
]

{ #category : #writing }
DcPDV >> extLength [

	^ self headerLength + self lengthField
]

{ #category : #accessing }
DcPDV >> fragment [

	^ fragment 
]

{ #category : #accessing }
DcPDV >> fragment: aByteArray [

 fragment:=aByteArray
]

{ #category : #accessing }
DcPDV >> header [

	^ header
]

{ #category : #writing }
DcPDV >> headerLength [
"Item length and pres.ctx ID"
	^ 4+1
]

{ #category : #initialization }
DcPDV >> initialize [ header:=0
]

{ #category : #testing }
DcPDV >> isCommand [

	^ (self header bitAnd: 1) > 0
]

{ #category : #testing }
DcPDV >> isData [

	^ (self header bitAnd: 1) = 0
]

{ #category : #testing }
DcPDV >> isLast [

	^ (self header bitAnd: 2) > 0
]

{ #category : #testing }
DcPDV >> isNotLast [

	^ (self header bitAnd: 2) = 0
]

{ #category : #writing }
DcPDV >> lengthField [
"header-byte + fragment"
	^ 1 + fragment size
]

{ #category : #accessing }
DcPDV >> presCtxId [
^presCtxId
]

{ #category : #accessing }
DcPDV >> presCtxId:anInt [

	presCtxId:=anInt
]

{ #category : #reading }
DcPDV >> readFrom: stream [

	| length pduStream |
	length := (stream next: 4) unsignedLongAt: 1 bigEndian: true.
	pduStream := DcLimitedReadStream on: stream length: length.
	presCtxId := pduStream next.
	self readPduFrom: pduStream
]

{ #category : #reading }
DcPDV >> readPduFrom: pduStream [
header := pduStream next.
	fragment := pduStream upToEnd
]

{ #category : #accessing }
DcPDV >> setCommand: aBoolean [

	| commandMask |
	commandMask := 14. "1110 as decimal"
	header := (header bitAnd: commandMask )bitOr: aBoolean asBit
]

{ #category : #accessing }
DcPDV >> setLast: aBoolean [

	| lastMask |
	lastMask := 13. "1101 as decimal"
	header := (header bitAnd: lastMask) bitOr:
		          (aBoolean asBit bitShift: 1)
		
	
]

{ #category : #writing }
DcPDV >> writeOn: stream [

	"length := (stream next: 4) unsignedLongAt: 1 bigEndian: true.
	pduStream := DcLimitedReadStream on: stream length: length.
	presCtxId := pduStream next."

	| lenBuf |
	lenBuf := (ByteArray new: 4)
		          unsignedLongAt: 1 put: self lengthField bigEndian: true;
		          yourself.
	stream
		nextPutAll: lenBuf;
		nextPut: presCtxId;
		nextPut: header;
		nextPutAll: fragment
]
