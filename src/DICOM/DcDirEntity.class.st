Class {
	#name : #DcDirEntity,
	#superclass : #Object,
	#instVars : [
		'records',
		'nextEntity',
		'nextRecord',
		'offsetLowerEntity',
		'type',
		'properties'
	],
	#category : #'DICOM-File'
}

{ #category : #initialization }
DcDirEntity >> initialize [

	records := OrderedCollection new.
]

{ #category : #'instance creation' }
DcDirEntity >> readFrom: aStream atPos: startPos explicitVR: explicitVR [

	| els inUse |
	aStream position: startPos.
	els := DcSqItem from: aStream explicitVR: explicitVR.
	nextRecord := els first.
	inUse := els second.
	offsetLowerEntity := els third.
	type := els fourth.
	properties := els allButFirst: 4.
	self halt

]
