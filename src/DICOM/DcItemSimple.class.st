Class {
	#name : #DcItemSimple,
	#superclass : #DcItem,
	#instVars : [
		'value'
	],
	#category : #'DICOM-ACSE'
}

{ #category : #comparing }
DcItemSimple >> = anObject [

	^ anObject isString
		  ifTrue: [ value = anObject ]
		  ifFalse: [ value = anObject value ]
]

{ #category : #comparing }
DcItemSimple >> myLength [

	^ value size
]

{ #category : #printing }
DcItemSimple >> printOn: stream [

	super printOn: stream.
	stream nextPut: $(.
	stream << value asString.
	stream nextPut: $)
]

{ #category : #comparing }
DcItemSimple >> readItemFrom: stream [

	self shouldBeImplemented 
]

{ #category : #comparing }
DcItemSimple >> value [

	^ value
]

{ #category : #comparing }
DcItemSimple >> value: aValue [

	value := aValue
]
