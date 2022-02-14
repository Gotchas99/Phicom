Class {
	#name : #DcFile,
	#superclass : #Object,
	#instVars : [
		'filename',
		'meta',
		'dataset'
	],
	#category : #'CAs-DICOM-File'
}

{ #category : #accessing }
DcFile >> filename: aString [ 
filename:=aString 
]

{ #category : #'as yet unclassified' }
DcFile >> informationGroupLength [
self flag:#todo.
	^ 0
]

{ #category : #'as yet unclassified' }
DcFile >> isExplicit [

	^ (meta at: 'TransferSyntaxUID')value = '1.2.840.10008.1.2.1'
]

{ #category : #accessing }
DcFile >> meta [ 

^meta
]

{ #category : #'as yet unclassified' }
DcFile >> read [

	filename asFileReference binaryReadStreamDo: [ :s | 
		meta := DcFileMeta readMetaFrom: s.

		dataset := DcDataSet readFrom: s explicitVR: self isExplicit ]
]
