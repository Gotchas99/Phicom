Class {
	#name : #DcTransferSyntax,
	#superclass : #Object,
	#instVars : [
		'uid',
		'name',
		'explictVR',
		'littleEndian'
	],
	#classVars : [
		'TsnName',
		'TsnUid'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'class initialization' }
DcTransferSyntax class >> add: paramArray [

	"uid, name, explicit_VR(optional, default explicit), endianness(optional, default little endian)"

	| tsn |
	tsn := self new.
	tsn uid: paramArray first.
	tsn name: paramArray second.
	tsn explictVR: (paramArray length >= 3
			 ifTrue: [ paramArray third ]
			 ifFalse: [ true ]).
	tsn littleEndian: (paramArray length >= 4
			 ifTrue: [ paramArray fourth ]
			 ifFalse: [ true ]).
	TsnUid at: tsn uid put: tsn.
	TsnName at:
	tsn name put: tsn
]

{ #category : #'class initialization' }
DcTransferSyntax class >> initialize [

	self initializeDict
]

{ #category : #'class initialization' }
DcTransferSyntax class >> initializeDict [

	TsnUid := Dictionary new.
	TsnName := Dictionary new.
	"uid, name, explicit_VR(optional, default explicit), endianness(optional, default little endian)"
	self
		add: #( '1.2.840.10008.1.2' , 'Implicit VR Little Endian'
			   , false ) .self
		add: #( '1.2.840.10008.1.2.1' , 'Explicit VR Little Endian' )
]

{ #category : #accessing }
DcTransferSyntax >> explictVR [

	^ explictVR
]

{ #category : #accessing }
DcTransferSyntax >> explictVR: aBoolean [

	explictVR := aBoolean



]

{ #category : #accessing }
DcTransferSyntax >> littleEndian [

	^ littleEndian
]

{ #category : #accessing }
DcTransferSyntax >> littleEndian: aBoolean [

	littleEndian := aBoolean


]

{ #category : #accessing }
DcTransferSyntax >> name [

	^ name
]

{ #category : #accessing }
DcTransferSyntax >> name: anObject [

	name := anObject
]

{ #category : #accessing }
DcTransferSyntax >> uid [

	^ uid
]

{ #category : #accessing }
DcTransferSyntax >> uid: anObject [

	uid := anObject
]
