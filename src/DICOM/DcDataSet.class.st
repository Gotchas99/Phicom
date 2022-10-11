"
A Data Set is constructed of Data Elements

The Data Elements in a Data Set shall be ordered by increasing Data Element Tag Number and shall occur at most once in a Data Set.
"
Class {
	#name : #DcDataSet,
	#superclass : #Object,
	#instVars : [
		'elements',
		'explicitVR',
		'dict'
	],
	#category : #'DICOM-Core'
}

{ #category : #documentation }
DcDataSet class >> docsTransferSyntax [

	"https://dicom.nema.org/medical/dicom/current/output/chtml/part05/chapter_A.html#sect_A.1"

	"This DICOM Implicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2""."

	"This DICOM Explicit VR Little Endian Transfer Syntax shall be identified by a UID of Value ""1.2.840.10008.1.2.1""."
]

{ #category : #'instance creation' }
DcDataSet class >> readFrom: aStream explicitVR: aBoolean [

^	(self new) explicitVR:aBoolean;readFrom:aStream
]

{ #category : #converting }
DcDataSet >> asDictionary [

	|  nextTagId assoc key |
	dict ifNotNil: [ ^ dict ].
	nextTagId := 0.
	dict := (elements collect: [ :el | 
		        assoc := el assoc.
		        key := assoc key = 'Private tag'
			               ifTrue: [ 
				               nextTagId := nextTagId + 1.
				               assoc key , ' ' , el tag hex ]
			               ifFalse: [ assoc key ].
		        key -> assoc value ]) asDictionary.
	^ dict
]

{ #category : #converting }
DcDataSet >> asSR [

	| tmp |
	self isSR ifFalse: [ Error signal: 'not an SR' ].
	tmp := DcSR new.

	^ tmp
]

{ #category : #accessing }
DcDataSet >> at: aKey [

	^ elements
		  detect: [ :el | el keyword = aKey ]
		  ifFound: [ :el | el value ]
		  ifNone: [ Error signal: 'element key not found' ]
]

{ #category : #accessing }
DcDataSet >> elements [
^elements
]

{ #category : #accessing }
DcDataSet >> explicitVR:aBoolean [
explicitVR:=aBoolean 
]

{ #category : #initialization }
DcDataSet >> initialize [

	elements := SortedCollection new.


	
]

{ #category : #testing }
DcDataSet >> isSR [

	^ (self asDictionary at: 'Modality') = 'SR' 
]

{ #category : #accessing }
DcDataSet >> readFrom: aStream [

	| e |
	elements := SortedCollection  new.
	[ aStream atEnd ] whileFalse: [ 
		e := DcElement from: aStream explicitVR: explicitVR.
		elements add: e ]
]
