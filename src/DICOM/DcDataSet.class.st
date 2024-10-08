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
		'readPixelData',
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
	tmp := DcSR new from: elements.

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
DcDataSet >> elementsForModule: aModulename [

	| mod tags matches matchElements matchTags |
	"tags := elements collect: [ :m | m keyword ]."
	mod := DcModule module: aModulename.
	matches := mod elementsIncluded: elements.
	"matchTags := matches collect: [ :t | t at: #TagHex ].
	self halt.
	matchElements := elements select: [ :e |
		                 matchTags anySatisfy: [ :t | t = e tag bin ] ]."
	^ matches
]

{ #category : #accessing }
DcDataSet >> explicitVR:aBoolean [
explicitVR:=aBoolean 
]

{ #category : #initialization }
DcDataSet >> initialize [

	elements := SortedCollection new.
	readPixelData:=true
]

{ #category : #inspecting }
DcDataSet >> inspectionString [

	<inspectorPresentationOrder: -10 title: 'DICOM Dataset'>
	^ SpTablePresenter new
		  addColumn:
			  ((SpStringTableColumn title: 'Index' evaluated: #displayKey)
				   width: 200);
		  addColumn:
			  (SpStringTableColumn title: 'Field' evaluated: #displayValue);
		  items: elements;
		  yourself
]

{ #category : #accessing }
DcDataSet >> iod [

	^ DcTable uidAtCode: ( self at: 'SOPClassUID')
]

{ #category : #testing }
DcDataSet >> isSR [

	^ (self asDictionary at: 'Modality') = 'SR' 
]

{ #category : #accessing }
DcDataSet >> modules [

	| allMods mods |
	allMods := DcModule modulesForIOD: self iod.
	mods := OrderPreservingDictionary new.
	 allMods do: [ :mod |
		  mods at: mod name put: (self elementsForModule: mod name) ].^mods
]

{ #category : #accessing }
DcDataSet >> nonEmptyElements [

	^ elements reject: [ :el | el isEmpty ] 
]

{ #category : #initialization }
DcDataSet >> readFrom: aStream [

	| e |
	elements := SortedCollection new.
	e := DcElement new.
	[ aStream atEnd or: [ e isPixelData ] ] whileFalse: [
		e := DcElement new
			     explicitVR: explicitVR;
			     readPixelData: readPixelData;
			     from: aStream.
		elements add: e ]
]

{ #category : #initialization }
DcDataSet >> readPixelData:aBoolean [
readPixelData:=aBoolean
]

{ #category : #accessing }
DcDataSet >> sequences [

	| els |
	els:= elements select:[:el|el vr='SQ'].
	^ els
]
