Class {
	#name : #DcFileSet,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcFileSet >> open [

	|  dir |
	"fref := (path , '/DICOMDIR') asFileReference.""fref binaryReadStreamDo: [ :s | "
	dir := DcDirFile new path: path.
	dir read. "]"
	^ dir
]

{ #category : #accessing }
DcFileSet >> path: aPathString [
path:= aPathString 
]
