Class {
	#name : #DcFile,
	#superclass : #Object,
	#instVars : [
		'meta',
		'filename'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcFile >> filename: aString [ 
filename:=aString 
]

{ #category : #testing }
DcFile >> isExplicitVR [

	^ (meta isExplicitVR ) 
]

{ #category : #accessing }
DcFile >> meta [ 

^meta
]

{ #category : #'as yet unclassified' }
DcFile >> read [

	filename asFileReference binaryReadStreamDo: [ :s | 
		meta := DcFileMeta readMetaFrom: s.
		self  readFrom: s ]
]
