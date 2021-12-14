Class {
	#name : #DcPDU,
	#superclass : #Object,
	#instVars : [
		'type',
		'items'
	],
	#classVars : [
		'TypeMap'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #'as yet unclassified' }
DcPDU class >> docs [

	"https://dicom.nema.org/medical/dicom/current/output/html/part08.html#sect_9.3"

	"The encoding of the DICOM UL PDUs is defined as follows (Big Endian byte ordering) :
	The Big Endian byte ordering has been chosen for consistency with the OSI and TCP/IP environment. This pertains to the DICOM UL PDU headers only. The encoding of the PDV message fragments is defined by the Transfer Syntax negotiated at association establishment."

	"Each PDU type shall consist of one or more bytes that when represented, are numbered sequentially, with byte 1 being the lowest byte number."

	
]

{ #category : #initialization }
DcPDU class >> initialize [

self 	initializeTypeMap
]

{ #category : #initialization }
DcPDU class >> initializeTypeMap [

	TypeMap := Dictionary new.
"	TypeMap at: 1 put: DcAssociateRq"
	.
	self allSubclassesDo: [ :c | TypeMap at: c type put: c ]
]

{ #category : #testing }
DcPDU class >> isKnownType: typeCode [
"Not used?"
	^ TypeMap includesKey: typeCode
]

{ #category : #'instance creation' }
DcPDU class >> readFrom: stream [

	| type pduClass |
	type := stream peek.
	pduClass := TypeMap at: type.
	^ pduClass new readFrom: stream
]

{ #category : #accessing }
DcPDU class >> type [

	^-1
]

{ #category : #comparing }
DcPDU >> <= otherPDU [

	^ self type <= otherPDU type
]

{ #category : #adding }
DcPDU >> addItem: anItem [

	items add: anItem
]

{ #category : #validating }
DcPDU >> checkLength [

	| buffstream b |
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     self  writeOn: buffstream.
		     buffstream close ].
	
	b size = self extLength ifFalse: [ 
	self halt ].

]

{ #category : #writing }
DcPDU >> extLength [

	^ self headerLength  + self lengthField
]

{ #category : #writing }
DcPDU >> headerLength [

	^ 1 + 1 + 4
]

{ #category : #initialization }
DcPDU >> initialize [

	type := self class type.
	items := SortedCollection new
]

{ #category : #testing }
DcPDU >> isAssociation [ 
^true
]

{ #category : #writing }
DcPDU >> items [ ^items
]

{ #category : #writing }
DcPDU >> lengthField [

	^ self myLength
	  + (items inject: 0 into: [ :sum :each | sum + each extLength ]) 
]

{ #category : #writing }
DcPDU >> myLength [

	"this and previous fields don't count"

	
	^ 0
]

{ #category : #'instance creation' }
DcPDU >> readFrom: stream [

	| length pduStream |
	self traceCr: self className ,' message recieved'.
	type := stream next.
	stream skip: 1.
	length := (stream next: 4) unsignedLongAt: 1 bigEndian: true.
	pduStream := DcPduReadStream on: stream pduLength: length.
	self readPduFrom: pduStream
]

{ #category : #'instance creation' }
DcPDU >> readPduFrom: stream [

	

	self subclassResponsibility
]

{ #category : #initialization }
DcPDU >> type [

	^self class type
]

{ #category : #writing }
DcPDU >> writeOn: stream [

		stream
		uint8: self type;
		uint8: 0;
		uint32: self lengthField
]
