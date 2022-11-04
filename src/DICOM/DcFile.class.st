Class {
	#name : #DcFile,
	#superclass : #Object,
	#instVars : [
		'filename',
		'explicitVR',
		'meta'
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

	self readStreamDo: [ :s | 
		meta := DcFileMeta readMetaFrom: s.
		explicitVR := meta isExplicitVR.
		self readFrom: s ]
]

{ #category : #'instance creation' }
DcFile >> readFrom: aStream [
self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
DcFile >> readStreamDo: aBlock [

	filename asFileReference binaryReadStreamDo: aBlock
]
