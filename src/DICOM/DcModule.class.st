Class {
	#name : #DcModule,
	#superclass : #Object,
	#instVars : [
		'name',
		'descr',
		'group',
		'attrs'
	],
	#classVars : [
		'IOD',
		'Modules'
	],
	#category : #'DICOM-Core'
}

{ #category : #'class initialization' }
DcModule class >> addGeneralImage [

	| m |
	m := self new
		     name: 'GeneralImage';
		     descr: 'General Image'.
	m addTag: '(0020,0013)'.
	m addTag: '(0020,0020)'.
	m addTag: '(0008,0023)'.

	m addTag: '(0008,0033)'.
	m addTag: '(0008,0008)'.
	m addTag: '(0008,0022)'.
	m addTag: '(0008,0032)'.

	m addTag: '(0020,1002)'.
	m addTag: '(0008,0032)'.

	Modules at: m name put: m
]

{ #category : #'class initialization' }
DcModule class >> addGeneralStudy [

	| m |
	m := self new
		     name: 'GeneralStudy';
		     descr: 'General Study'.
	m addTag: '(0020,000D)'.
	m addTag: '(0008,0020)'.
	m addTag: '(0008,0030)'.
	m addTag: '(0008,0090)'.
	m addTag: '(0020,0010)'.
	m addTag: '(0008,1030)'.
	m addTag: '(0008,0050)'.
		Modules at: m name put: m.

]

{ #category : #'class initialization' }
DcModule class >> addImagePixel [

	| m |
	m := self new
		     name: 'ImagePixel';
		     descr: 'Image Pixel'.
	m addMacro:'ImagePixel'.
	Modules at: m name put: m
]

{ #category : #'class initialization' }
DcModule class >> addMultiFrame [

	| m |
	m := self new
		     name: 'MultiFrame';
		     descr: 'Multi Frame'.
	m addTag: '(0028,0008)'.
	m addTag: '(0028,0009)'.

	Modules at: m name put: m
]

{ #category : #'class initialization' }
DcModule class >> addPatient [

	| m |
	m := self new
		     name: 'Patient';
		     descr: 'Patient'.
	m addTag: '(0010,0010)'.
	m addTag: '(0010,0020)'.
	m addTag: '(0010,0022)'.
	Modules at: m name put: m
]

{ #category : #'class initialization' }
DcModule class >> addVLWholeSlideMicroscopyImage [

	| m tagIds |
	m := self new
		     name: 'VLWholeSlideMicroscopyImage';
		     descr: 'VL Whole Slide Microscopy Image'.
	tagIds := #( '(0008,0008)' '(0048,0001)' '(0048,0002)' '(0048,0003)' '(0048,0006)' '(0048,0007)'
	'(0048,0008)' '(0028,0002)' '(0028,0008)' '(0028,0100)' '(0028,0101)' '(0008,002A)' '(0018,9073)' 
	'(0048,0010)' ).
	tagIds do: [ :tagId | m addTag: tagId ].

	Modules at: m name put: m
]

{ #category : #'class initialization' }
DcModule class >> initialize [

	<script>
	Modules := Dictionary new.
	self addPatient.
	self addGeneralStudy.
	self addGeneralImage.
	self addMultiFrame.
	self addImagePixel.
	self addVLWholeSlideMicroscopyImage.
	self initializeIOD
]

{ #category : #'class initialization' }
DcModule class >> initializeIOD [

	IOD := Dictionary new.
	IOD at: 'CTImageStorage' put: {
			(self module: #Patient).
			(self module: #GeneralStudy).
			(self module: #GeneralImage) }.
	IOD at: 'VLWholeSlideMicroscopyImageStorage' put: {
			(self module: #Patient).
			(self module: #GeneralStudy).
			(self module: #GeneralImage).
			(self module: #MultiFrame).
			(self module: #ImagePixel).
		(self module: #VLWholeSlideMicroscopyImage) }.
	self module: #GeneralImage
]

{ #category : #accessing }
DcModule class >> module:aString [
^Modules at:aString
]

{ #category : #accessing }
DcModule class >> modules [
^Modules keys
]

{ #category : #accessing }
DcModule class >> modulesForIOD: aString [

	^IOD at:aString
]

{ #category : #adding }
DcModule >> addMacro: aMacroName [

	| tmp  |
	tmp := DcMacro macro: aMacroName.
	attrs addAll: tmp tags
]

{ #category : #adding }
DcModule >> addTag: tagID [

	| tmp tag |
	tmp := DcTable tagTable atHex: tagID.
	tag := DcTag fromString: (tmp at: #Tag).
	attrs add: tag

]

{ #category : #printing }
DcModule >> descr [

	^ descr ifNil:[name]
]

{ #category : #accessing }
DcModule >> descr:aString [
descr:=aString
]

{ #category : #accessing }
DcModule >> elementsIncluded: anElementList [

	| tmp |
 	tmp := anElementList select: [ :el | attrs includes: el tag ].
	^ tmp
]

{ #category : #initialization }
DcModule >> initialize [

	attrs := Set new
]

{ #category : #accessing }
DcModule >> matchingTags: tagList [

	| tmp |
	tmp := OrderedCollection new.
	tmp := tagList
		       collect: [ :t |
			       attrs
				       detect: [ :a | (a at: #Keyword) = t ]
				       ifFound: [ :a | a ]
				       ifNone: [ nil ] ] thenReject: [ :t | t isNil ].
	^ tmp
]

{ #category : #accessing }
DcModule >> name: aString [
"setter för name"
	name := aString
]

{ #category : #printing }
DcModule >> printOn: aStream [

	aStream << 'Module: ' << self descr
]
