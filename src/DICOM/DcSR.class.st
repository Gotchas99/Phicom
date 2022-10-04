Class {
	#name : #DcSR,
	#superclass : #Object,
	#category : #'DICOM-SR'
}

{ #category : #printing }
DcSR >> printOn: aStream [

	aStream << 'SR' << '(' << 'codeValue' << ')'
]
