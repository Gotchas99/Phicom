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

	| numTemp |
	super from: elementList.
	numTemp := (self at: 'MeasuredValueSequence' inList: elementList)
		           first.
	num := numTemp at: #NumericValue.
	unit := ((numTemp at: #MeasurementUnitsCodeSequence)first )at:#CodeMeaning
]

{ #category : #'instance creation' }
DcSRvalueNum >> printOn: aStream [

	super printOn: aStream.
	aStream << '=' << num asString <<' '<<unit
]
