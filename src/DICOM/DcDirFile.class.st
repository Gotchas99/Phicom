Class {
	#name : #DcDirFile,
	#superclass : #DcFile,
	#instVars : [
		'root',
		'offsetFirstRecord'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcDirFile >> path [
	^ filename
]

{ #category : #accessing }
DcDirFile >> path:aPath [
self filename: aPath , '/DICOMDIR'
]

{ #category : #'instance creation' }
DcDirFile >> readFrom: aStream [

	| fileSetId consistencyTag els el |
	consistencyTag := DcTag fromString: '(0004,1212)'.
	els := OrderedCollection new.
	fileSetId := DcElement from: aStream explicitVR: explicitVR.
	[ 
	el := DcElement from: aStream explicitVR: explicitVR.
	els add: el ] doWhileFalse: [ el tag = consistencyTag ].
	offsetFirstRecord := (els detect: [ :e | 
		                      e isTagname:
			                      'OffsetoftheFirstDirectoryRecordoftheRootDirectoryEntity' ])
		                     value.
	root := DcDirEntity new file: self;
		        readFrom: aStream
		        atPos: offsetFirstRecord
		        explicitVR: explicitVR
]

{ #category : #'as yet unclassified' }
DcDirFile >> rootEntity [
^root
]
