Class {
	#name : #DcAssociateStart,
	#superclass : #DcPDU,
	#instVars : [
		'version',
		'calledAET',
		'callingAET'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcAssociateStart class >> serviceName [

	^ #aAssociate
]

{ #category : #writing }
DcAssociateStart >> calledAET [

	^ calledAET 
]

{ #category : #writing }
DcAssociateStart >> calledAET: aString [

		calledAET := aString
]

{ #category : #writing }
DcAssociateStart >> callingAET [

	^ callingAET 
]

{ #category : #writing }
DcAssociateStart >> callingAET: aString [

	 callingAET := aString
]

{ #category : #'as yet unclassified' }
DcAssociateStart >> checkLength [

	| buffstream b |
	items do:[:each|each checkLength ].
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     self writeOn: buffstream.
		     buffstream close ].

	b size = self extLength ifFalse: [ self halt ]
]

{ #category : #writing }
DcAssociateStart >> myLength [

	^ 2 + 2 + 16 + 16 + 32
	 
]

{ #category : #'as yet unclassified' }
DcAssociateStart >> readPduFrom: stream [

	| it  |
	version := (stream next: 2) unsignedShortAt: 1 bigEndian: true.
	stream skip: 2.
	self calledAET: (stream next: 16) asString trim.
	self callingAET: (stream next: 16) asString trim.
	stream skip: 32.
	"bytesLeft := lengthField - self myLength.
	[ bytesLeft > 0 ] whileTrue: [ "
	[ stream atEnd ] whileFalse: [ 
		it := DcItem readFrom: stream.
		items add: it
		"bytesLeft := bytesLeft - it extLength" ]
]

{ #category : #'as yet unclassified' }
DcAssociateStart >> version [
^version
]

{ #category : #writing }
DcAssociateStart >> writeOn: stream [

	| blank32 |
	super writeOn: stream.
	blank32 := ByteArray new: 32.
	stream
		uint16: 1;
		uint16: 0;
		nextPutAll: (self calledAET padRightTo: 16);
		nextPutAll: (self callingAET padRightTo: 16);
		nextPutAll: blank32.
	self items do: [ :item | item writeOn: stream ]
]
