Class {
	#name : #DcObjectFile,
	#superclass : #DcFile,
	#instVars : [
		'dataset'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcObjectFile >> dataset [ ^dataset
]

{ #category : #'as yet unclassified' }
DcObjectFile >> informationGroupLength [
self flag:#todo.
	^ 0
]

{ #category : #'instance creation' }
DcObjectFile >> readFrom: s [

	dataset := DcDataSet readFrom: s explicitVR: meta isExplicitVR
]
