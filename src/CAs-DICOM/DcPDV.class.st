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
		'userdata',
		'presCtxId'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #'instance creation' }
DcPDV class >> readFrom: stream [

	
	^ self  new readFrom: stream
]

{ #category : #accessing }
DcPDV >> elements [

	| tmp elements explicitVR |
	elements := OrderedCollection new.
	ReadStream with: userdata do: [ :s | 
[ s atEnd ]whileFalse:		[tmp := self isCommand
			       ifTrue: [ DcElement from: s explicitVR: false ]
			       ifFalse: [ 
				       self halt. "explicitVR from PresCtx"
				       explicitVR := true.
				       DcElement from: s explicitVR: explicitVR ].
		elements add: tmp] ].
	^ elements
]

{ #category : #writing }
DcPDV >> extLength [

	^ self headerLength + self lengthField
]

{ #category : #accessing }
DcPDV >> fragment [

	^ userdata allButFirst
]

{ #category : #accessing }
DcPDV >> header [

	^ userdata first
]

{ #category : #writing }
DcPDV >> headerLength [

	^ 4+1
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

	self halt.
]

{ #category : #accessing }
DcPDV >> payload [
^userdata
]

{ #category : #accessing }
DcPDV >> presCtxId [
^presCtxId
]

{ #category : #'instance creation' }
DcPDV >> readFrom: stream [

	| length pduStream |
	length := (stream next: 4) unsignedLongAt: 1 bigEndian: true.
	pduStream := DcLimitedReadStream on: stream length: length.
	presCtxId := pduStream next.
	self readPduFrom: pduStream
]

{ #category : #'instance creation' }
DcPDV >> readPduFrom: pduStream [

	"header := pduStream next."
	userdata := pduStream upToEnd
]

{ #category : #accessing }
DcPDV >> userdata [

	^ userdata
]
