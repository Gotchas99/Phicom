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

{ #category : #'as yet unclassified' }
DcObjectFile >> savePixelData [

	| pxFile pixelEl |
	pxFile := (filename , '.jpg') asFileReference.
	pixelEl := dataset at: #PixelData.
	pxFile binaryWriteStreamDo: [ :s | s nextPutAll: pixelEl ]
]
