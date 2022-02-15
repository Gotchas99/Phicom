Class {
	#name : #DcSyntax,
	#superclass : #Object,
	#instVars : [
		'uid',
		'name',
		'littleEndian',
		'explicitVR'
	],
	#classVars : [
		'SyntaxName',
		'SyntaxUid'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'class initialization' }
DcSyntax class >> add: paramArray [

	"uid, name, explicit_VR(optional, default explicit), endianness(optional, default little endian)"

	| tsn |
	tsn := self new.
	tsn uid: paramArray first.
	tsn name: paramArray second.
	tsn explictVR: (paramArray size >= 3
			 ifTrue: [ paramArray third ]
			 ifFalse: [ true ]).
	tsn littleEndian: (paramArray size >= 4
			 ifTrue: [ paramArray fourth ]
			 ifFalse: [ true ]).
	SyntaxUid at: tsn uid put: tsn.
	SyntaxName at:
	tsn name put: tsn
]

{ #category : #'class initialization' }
DcSyntax class >> atUid: aUid [

	^SyntaxUid at:aUid
]

{ #category : #'class initialization' }
DcSyntax class >> initialize [
SyntaxUid := Dictionary new.
	SyntaxName := Dictionary new.
	self initializeTransferSyntaxes
]

{ #category : #'class initialization' }
DcSyntax class >> initializeAbstractSyntaxes [

	"uid, name, explicit_VR(optional, default explicit)"

	self add: #( '1.2.840.10008.1.1' 'abst syntax ???' ).

]

{ #category : #'class initialization' }
DcSyntax class >> initializeTransferSyntaxes [

	
	"uid, name, explicit_VR(optional, default explicit), endianness(optional, default little endian)"
	self add: #( '1.2.840.10008.1.2' 'Implicit VR Little Endian'
		   false ).
	self add: #( '1.2.840.10008.1.2.1' 'Explicit VR Little Endian' )
]

{ #category : #converting }
DcSyntax >> asSyntax [

	^ self
]

{ #category : #accessing }
DcSyntax >> explictVR [

	^ explicitVR
]

{ #category : #accessing }
DcSyntax >> explictVR: aBoolean [

	explicitVR := aBoolean



]

{ #category : #testing }
DcSyntax >> isExplicitVR [

	^ explicitVR
]

{ #category : #accessing }
DcSyntax >> littleEndian [

	^ littleEndian
]

{ #category : #accessing }
DcSyntax >> littleEndian: aBoolean [

	littleEndian := aBoolean


]

{ #category : #accessing }
DcSyntax >> name [

	^ name
]

{ #category : #accessing }
DcSyntax >> name: anObject [

	name := anObject
]

{ #category : #accessing }
DcSyntax >> uid [

	^ uid
]

{ #category : #accessing }
DcSyntax >> uid: anObject [

	uid := anObject
]
