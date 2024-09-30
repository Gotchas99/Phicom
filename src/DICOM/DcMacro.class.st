Class {
	#name : #DcMacro,
	#superclass : #Object,
	#instVars : [
		'name',
		'tags',
		'descr'
	],
	#classVars : [
		'Macros'
	],
	#category : #'DICOM-Core'
}

{ #category : #adding }
DcMacro class >> addImagePixel [

	| m |
	m := self new
		     name: 'ImagePixel';
		     descr: 'Image Pixel'.
	m addTag: '(0028,0002)'.
	m addTag: '(0028,0010)'.
	m addTag: '(0028,0011)'.
	m addTag: '(0028,0100)'.
	m addTag: '(0028,0101)'.
	m addTag: '(7FE0,0010)'.
	m addTag: '(0028,2000)'.
	Macros at: m name put: m
]

{ #category : #'class initialization' }
DcMacro class >> initialize [

	<script>
	Macros := Dictionary new.
	self addImagePixel
]

{ #category : #accessing }
DcMacro class >> macro: aMacroName [

	^Macros at: aMacroName 
]

{ #category : #adding }
DcMacro >> addTag: tagID [

	| tmp tag |
	tmp := DcTable tagTable atHex: tagID.
	tag := DcTag fromString: (tmp at: #Tag).
	tags add: tag
]

{ #category : #accessing }
DcMacro >> descr: aString [

descr := aString
]

{ #category : #initialization }
DcMacro >> initialize [

	tags := Set new
]

{ #category : #accessing }
DcMacro >> name [  
^

	name 
]

{ #category : #accessing }
DcMacro >> name: aString [
name:=aString 
]

{ #category : #accessing }
DcMacro >> tags [

^tags
]
