Class {
	#name : #DcDirEntity,
	#superclass : #Object,
	#instVars : [
		'records'
	],
	#category : #'DICOM-File'
}

{ #category : #initialization }
DcDirEntity >> initialize [

	records := OrderedCollection new.
]

{ #category : #'instance creation' }
DcDirEntity >> readFrom: aStream explicitVR: explicitVR [

	| fileSetId consistency els el |
	consistency := DcTag fromString: '(0004,1212)'.
	els := OrderedCollection new.
	fileSetId := DcElement from: aStream explicitVR: explicitVR.
	[ 
	el := DcElement from: aStream explicitVR: explicitVR.
	els add: el ] doWhileFalse: [ el tag = consistency ].
self halt.el := DcElement from: aStream explicitVR: explicitVR.
]
