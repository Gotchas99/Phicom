Class {
	#name : #DcDataSet,
	#superclass : #Object,
	#instVars : [
		'elements',
		'explicitVR'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #'as yet unclassified' }
DcDataSet class >> docsTransferSyntax [

	"https://dicom.nema.org/medical/dicom/current/output/chtml/part05/chapter_A.html#sect_A.1"

	"This DICOM Implicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2""."

	"This DICOM Explicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2.1""."
]

{ #category : #'as yet unclassified' }
DcDataSet class >> readFrom: aStream explicitVR: aBoolean [

^	(self new) explicitVR:aBoolean;readFrom:aStream
]

{ #category : #accessing }
DcDataSet >> elements [
^elements
]

{ #category : #accessing }
DcDataSet >> explicitVR:aBoolean [
explicitVR:=aBoolean 
]

{ #category : #accessing }
DcDataSet >> readFrom: s [

	| e |
	elements := SortedCollection new.
	[ s atEnd ] whileFalse: [ 
		e := DcElement from: s explicitVR: explicitVR.
		elements add: e ]
]
