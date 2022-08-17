Class {
	#name : #DcItemAppContext,
	#superclass : #DcItemUid,
	#category : #'DICOM-ACSE'
}

{ #category : #accessing }
DcItemAppContext class >> itemType [

	^ Integer readFrom: '10H' base:16
]

{ #category : #'as yet unclassified' }
DcItemAppContext >> docs_VR [ "A single DICOM Application Context Name is defined for this version of this Standard. This name is ""1.2.840.10008.3.1.1.1"""
]

{ #category : #accessing }
DcItemAppContext >> initialize [

	super initialize.
	value := '1.2.840.10008.3.1.1.1'
]

{ #category : #testing }
DcItemAppContext >> isValid [

	^ value = '1.2.840.10008.3.1.1.1'
]

{ #category : #accessing }
DcItemAppContext >> value: aString [

	[ aString = '1.2.840.10008.3.1.1.1' ] ifFalse: [ 
		Error signal: 'app context name not valid' ]
]
