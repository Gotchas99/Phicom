Class {
	#name : #DcModule,
	#superclass : #Object,
	#instVars : [
		'name',
		'descr',
		'attrs'
	],
	#classVars : [
		'IOD',
		'Modules'
	],
	#category : #'DICOM-Core'
}

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
	^ m
]

{ #category : #'class initialization' }
DcModule class >> addPatient [

	| m |
	m := self new name: 'Patient'.
	m addTag: '(0010,0010)'.
	m addTag: '(0010,0020)'.
	m addTag: '(0010,0022)'.
	^ m
]

{ #category : #'class initialization' }
DcModule class >> initialize [

	<script>
	Modules := Dictionary new.
	Modules at: #Patient put: self addPatient.
	Modules at: #GeneralStudy put: self addGeneralStudy.
	self initializeIOD
]

{ #category : #'class initialization' }
DcModule class >> initializeIOD [

	IOD := Dictionary new.
	IOD at: 'CTImageStorage' put: {
			(self module: #Patient).
			(self module: #GeneralStudy) }.
	IOD at:'VLWholeSlideMicroscopyImageStorage' put: {
			(self module: #Patient).
			(self module: #GeneralStudy) }.
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
DcModule >> addTag: tagID [

	| tmp |
	tmp := DcTable tagTable atHex: tagID.
	attrs at: (tmp at:#TagHex)put: tmp
]

{ #category : #printing }
DcModule >> descr [

	^ descr ifNil:[name]
]

{ #category : #accessing }
DcModule >> descr:aString [
descr:=aString
]

{ #category : #'as yet unclassified' }
DcModule >> elementsIncluded: aList [

	| tmp |
	tmp := OrderedCollection new.
	tmp := aList asOrderedCollection
		       collect: [ :el |
			       attrs
				       detect: [ :a | (a at: #Tag) = el tag hex ]
				       ifFound: [ :a |el ]
				       ifNone: [ nil ] ]
		       thenReject: [ :el | el isNil ].
	^ tmp
]

{ #category : #initialization }
DcModule >> initialize [

	attrs := Dictionary new
]

{ #category : #'as yet unclassified' }
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

	name := aString
]

{ #category : #printing }
DcModule >> printOn: aStream [

	aStream << 'Module: ' << self descr
]
