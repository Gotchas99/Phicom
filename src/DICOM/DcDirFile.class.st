Class {
	#name : #DcDirFile,
	#superclass : #DcFile,
	#instVars : [
		'root'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcDirFile >> path:aPath [
self filename: aPath , '/DICOMDIR'
]

{ #category : #'instance creation' }
DcDirFile >> readFrom: s [

	root := DcDirEntity new readFrom: s explicitVR: meta isExplicitVR
]
