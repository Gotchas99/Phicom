Class {
	#name : #DcSRvalueNum,
	#superclass : #DcSRvalueRel,
	#instVars : [
		'num',
		'unit'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueNum class >> valueType [

	^ 'NUM'
]

{ #category : #'instance creation' }
DcSRvalueNum >> from: elementList [

	| numTemp unitSeq |
	super from: elementList.
	numTemp := (self at: 'MeasuredValueSequence' inList: elementList)
		           first.
	num := (numTemp detect: [ :e | e keyword = #NumericValue ])
		          value. 
	unitSeq := (numTemp detect: [ :e | e keyword = #MeasurementUnitsCodeSequence ])
		          value .	
			unit := (unitSeq first detect: [ :e | e keyword = #CodeMeaning ])  value
]

{ #category : #'instance creation' }
DcSRvalueNum >> printOn: aStream [

	super printOn: aStream.
	aStream << '=' << num asString <<' '<<unit
]

{ #category : #'instance creation' }
DcSRvalueNum >> valueString [

	^ num asString , ' ' , unit
]
