Class {
	#name : #DcTriplet,
	#superclass : #Object,
	#instVars : [
		'scheme',
		'codeValue',
		'meaning'
	],
	#category : #'CAs-DICOM-SR'
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

	| dict  |
	dict := aSeq value first.
	scheme := dict at: 'CodingSchemeDesignator'.
	meaning := dict at: 'CodeMeaning'.
	codeValue := dict at: 'CodeValue'
]

{ #category : #accessing }
DcTriplet >> meaning [
^meaning
]

{ #category : #printing }
DcTriplet >> printOn: aStream [

	aStream << meaning<<'('<<codeValue<<')'
]
