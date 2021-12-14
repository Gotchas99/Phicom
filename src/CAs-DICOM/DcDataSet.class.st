Class {
	#name : #DcDataSet,
	#superclass : #Object,
	#instVars : [
		'elements',
		'explicit'
	],
	#category : #'CAs-DICOM-Message'
}

{ #category : #'as yet unclassified' }
DcDataSet class >> docsTransferSyntax [

	"https://dicom.nema.org/medical/dicom/current/output/chtml/part05/chapter_A.html#sect_A.1"

	"This DICOM Implicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2""."

	"This DICOM Explicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2.1""."
]

{ #category : #'as yet unclassified' }
DcDataSet class >> readFrom: aStream explicit: aBoolean [

^	(self new) explicit:aBoolean;readFrom:aStream
]

{ #category : #accessing }
DcDataSet >> explicit:aBoolean [
explicit:=aBoolean 
]

{ #category : #accessing }
DcDataSet >> readFrom: s [

	| e |
	elements := OrderedCollection new.
	[ s atEnd ] whileFalse: [ 
		e := DcElement from: s explicitVR: explicit.
		elements add: e ]
]
