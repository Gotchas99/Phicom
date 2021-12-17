Class {
	#name : #DcFragmentStream,
	#superclass : #ReadStream,
	#instVars : [
		'fragments',
		'fragStream',
		'readStream'
	],
	#category : #'CAs-DICOM-Util'
}

{ #category : #testing }
DcFragmentStream >> atEnd [

	^ (fragStream atEnd)and:[readStream atEnd]
]

{ #category : #accessing }
DcFragmentStream >> next [

	readStream atEnd ifTrue: [ 
		readStream := self nextBuffer ].
	^ readStream next
]

{ #category : #accessing }
DcFragmentStream >> next: anInteger [

	ByteArray
		new: anInteger
		streamContents: [ :out | out << self next ]
]

{ #category : #'instance creation' }
DcFragmentStream >> nextBuffer [ ^ ReadStream on: fragStream next
]

{ #category : #'instance creation' }
DcFragmentStream >> on: aFragmentList [

	fragStream := ReadStream on: aFragmentList.
	readStream := self nextBuffer
]
