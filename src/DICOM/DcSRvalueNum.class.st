Class {
	#name : #DcSRvalueNum,
	#superclass : #DcSRvalueRel,
	#instVars : [
		'num'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueNum class >> valueType [

	^ 'NUM'
]

{ #category : #'instance creation' }
DcSRvalueNum >> from: elementList [

	super from: elementList.
	num := self at: 'MeasuredValueSequence' inList: elementList
]
