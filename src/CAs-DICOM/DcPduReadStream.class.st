Class {
	#name : #DcPduReadStream,
	#superclass : #DecoratorStream,
	#instVars : [
		'pduLength',
		'limit'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #'as yet unclassified' }
DcPduReadStream class >> on: aStream pduLength: anInt [

	^ self basicNew
		  on: aStream;
		pduLength:anInt;
		  yourself
]

{ #category : #accessing }
DcPduReadStream >> atEnd [

	^ decoratedStream atEnd or: [ self position >= limit ]
]

{ #category : #accessing }
DcPduReadStream >> next: anInteger [

	"Answer the next anInteger elements of my stream. 
	Must override because default uses OrderedCollection."

	| newArray |
	newArray := ByteArray  new: anInteger.
	1 to: anInteger do: [ :index | newArray at: index put: self next ].
	^ newArray
]

{ #category : #accessing }
DcPduReadStream >> on: aStream [

	super on: aStream.

]

{ #category : #accessing }
DcPduReadStream >> pduLength [
^
	pduLength 
]

{ #category : #accessing }
DcPduReadStream >> pduLength: anInt [

	pduLength := anInt. limit:= self position+pduLength 
]

{ #category : #accessing }
DcPduReadStream >> skip: anInteger [

	"Set the receiver's position to be the current position+anInteger. A 
	subclass might choose to be more helpful and select the minimum of the 
	receiver's size and position+anInteger, or the maximum of 1 and 
	position+anInteger for the repositioning."

	decoratedStream skip: anInteger
]

{ #category : #accessing }
DcPduReadStream >> upToEnd [

	"Answer a subcollection from the current access position through the last element of the receiver."

	| len |
	len := limit - self position .
	^ self next: len
]
