Class {
	#name : #DcLimitedReadStream,
	#superclass : #DecoratorStream,
	#instVars : [
		'limit',
		'length'
	],
	#category : #'DICOM-Util'
}

{ #category : #'as yet unclassified' }
DcLimitedReadStream class >> on: aStream length: anInt [

	^ self basicNew
		  on: aStream;
		length:anInt;
		  yourself
]

{ #category : #accessing }
DcLimitedReadStream >> atEnd [

	^ decoratedStream atEnd or: [ self position >= limit ]
]

{ #category : #accessing }
DcLimitedReadStream >> length [
^
	length 
]

{ #category : #accessing }
DcLimitedReadStream >> length: anInt [

	length := anInt. limit:= self position+length 
]

{ #category : #accessing }
DcLimitedReadStream >> next: anInteger [

	"Answer the next anInteger elements of my stream. 
	Must override because default uses OrderedCollection."

	| newArray |
	newArray := decoratedStream collectionSpecies new: anInteger.
	1 to: anInteger do: [ :index | 
self atEnd ifTrue:[		SubscriptOutOfBounds signalFor: index].
		newArray at: index put: self next ].
	^ newArray
]

{ #category : #accessing }
DcLimitedReadStream >> on: aStream [

	super on: aStream.

]

{ #category : #accessing }
DcLimitedReadStream >> skip: anInteger [

	"Set the receiver's position to be the current position+anInteger. A 
	subclass might choose to be more helpful and select the minimum of the 
	receiver's size and position+anInteger, or the maximum of 1 and 
	position+anInteger for the repositioning."

	decoratedStream skip: anInteger
]

{ #category : #accessing }
DcLimitedReadStream >> upToEnd [

	"Answer a subcollection from the current access position through the last element of the receiver."

	| len |
	len := limit - self position .
	^ self next: len
]
