Class {
	#name : #DcMacro,
	#superclass : #Object,
	#instVars : [
		'name',
		'tags'
	],
	#category : #'DICOM-Core'
}

{ #category : #initialization }
DcMacro >> initialize [

	name := '<unknown>'.
	tags:= SortedCollection new.
]
