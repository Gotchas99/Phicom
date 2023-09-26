Class {
	#name : #DcObjectFile,
	#superclass : #DcFile,
	#instVars : [
		'dataset',
		'readPixelData'
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

{ #category : #initialization }
DcObjectFile >> initialize [

	explicitVR := false.
	readPixelData := true
]

{ #category : #'instance creation' }
DcObjectFile >> readFrom: s [

	dataset := DcDataSet new
		           explicitVR: meta isExplicitVR;
		           readPixelData: readPixelData;
		           readFrom: s.

]

{ #category : #accessing }
DcObjectFile >> readPixelData: aBoolean [

	readPixelData:= aBoolean 
]

{ #category : #'instance creation' }
DcObjectFile >> readWithoutPixelFrom: s [

	dataset := DcDataSet new 
		           explicitVR: meta isExplicitVR;
		           readWithoutPixelFrom: s
]

{ #category : #'as yet unclassified' }
DcObjectFile >> savePixelData [

	| pxFile pixelEl |
	pxFile := (filename , '.jpg') asFileReference.
	pixelEl := dataset at: #PixelData.
	pxFile binaryWriteStreamDo: [ :s | s nextPutAll: pixelEl ]
]
