Class {
	#name : #DcModule,
	#superclass : #Object,
	#instVars : [
		'descr',
		'attrs'
	],
	#classVars : [
		'Modules'
	],
	#category : #'DICOM-Core'
}

{ #category : #'class initialization' }
DcModule class >> addPatient [

	| m |
	m := self new descr: 'Patient module'.
	m addTag: '(0010,0010)'.
	m addTag: '(0010,0020)'.
m addTag: 	'(0010,0022)'.
	^ m
]

{ #category : #'class initialization' }
DcModule class >> initialize [

	<script>
	Modules := Dictionary new.
	Modules at: #PATIENT put: self addPatient. Modules inspect
]

{ #category : #accessing }
DcModule class >> module:aString [
^Modules at:aString
]

{ #category : #accessing }
DcModule class >> modules [
^Modules keys
]

{ #category : #adding }
DcModule >> addTag: tagID [

	| tmp |
	tmp := DcTable tagTable atHex: tagID.
	attrs at: (tmp at:#TagHex)put: tmp
]

{ #category : #accessing }
DcModule >> descr:aString [
descr:=aString
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
				       detect: [ :a | (a at: #Tag) = t ]
				       ifFound: [ :a | a ]
				       ifNone: [ nil ] ] thenReject: [ :t | t isNil ].
	^ tmp
]
