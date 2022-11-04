Class {
	#name : #DcFileSet,
	#superclass : #Object,
	#instVars : [
		'path',
		'dir'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcFileSet >> path: aPathString [
path:= aPathString 
]

{ #category : #accessing }
DcFileSet >> read [

	dir := DcDirFile new path: path.
	dir read. 
	^ dir
]
