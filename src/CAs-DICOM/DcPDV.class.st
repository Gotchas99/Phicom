Class {
	#name : #DcPDV,
	#superclass : #Object,
	#instVars : [
		'presCtx',
		'header',
		'payload'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #'instance creation' }
DcPDV class >> readFrom: stream [

	
	^ self  new readFrom: stream
]

{ #category : #accessing }
DcPDV >> elements [

	| tmp elements explicitVR |
	elements := OrderedCollection new.
	ReadStream with: payload do: [ :s | 
		tmp := self isCommand
			       ifTrue: [ DcElement from: s explicitVR: false ]
			       ifFalse: [ 
				       self halt. "explicitVR from PresCtx"
				       explicitVR := true.
				       DcElement from: s explicitVR: explicitVR ].
		elements add: tmp ].
	^ elements
]

{ #category : #writing }
DcPDV >> extLength [

	^ self headerLength + self lengthField
]

{ #category : #writing }
DcPDV >> headerLength [

	^ 4+1
]

{ #category : #testing }
DcPDV >> isCommand [

	^ (header bitAnd: 1) >0
]

{ #category : #testing }
DcPDV >> isData [

	^ (header bitAnd: 1) = 0
	

]

{ #category : #testing }
DcPDV >> isLast [

	^ (header bitAnd: 2) >0
]

{ #category : #testing }
DcPDV >> isNotLast [

	^ (header bitAnd: 2) = 0
]

{ #category : #writing }
DcPDV >> lengthField [

	self halt.
]

{ #category : #accessing }
DcPDV >> payload [
^payload
]

{ #category : #'instance creation' }
DcPDV >> readFrom: stream [

	| length pduStream |
	length := (stream next: 4) unsignedLongAt: 1 bigEndian: true.
	pduStream := DcLimitedReadStream on: stream length: length.
	presCtx := pduStream next.
	self readPduFrom: pduStream
]

{ #category : #'instance creation' }
DcPDV >> readPduFrom: pduStream [

	header := pduStream next.
	payload := pduStream upToEnd.
]
