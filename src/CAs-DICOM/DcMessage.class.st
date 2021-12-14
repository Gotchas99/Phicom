Class {
	#name : #DcMessage,
	#superclass : #Object,
	#instVars : [
		'commandSet',
		'dataSet'
	],
	#category : #'CAs-DICOM-Message'
}

{ #category : #initialization }
DcMessage >> initialize [

	commandSet:=SortedCollection new.dataSet:=OrderedCollection new.
]
