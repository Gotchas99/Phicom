Class {
	#name : #DcTriplet,
	#superclass : #Object,
	#instVars : [
		'scheme',
		'codeValue',
		'meaning'
	],
	#category : #'DICOM-SR'
}

{ #category : #'instance creation' }
DcTriplet class >> fromSeq: aSeq [

	^ self new fromSeq: aSeq
]

{ #category : #accessing }
DcTriplet >> codeValue [

	^ codeValue
]

{ #category : #'instance creation' }
DcTriplet >> fromSeq: aSeq [

	| sq |
	sq := aSeq value first.
	scheme := (sq detect: [ :e | e keyword = 'CodingSchemeDesignator' ])
		          value. 
	meaning := (sq detect: [ :e | e keyword = 'CodeMeaning' ]) value.
	codeValue := (sq detect: [ :e | e keyword = 'CodeValue' ]) value
]

{ #category : #accessing }
DcTriplet >> meaning [
^meaning
]

{ #category : #printing }
DcTriplet >> printOn: aStream [

	aStream << meaning<<'('<<codeValue<<')'
]
