Class {
	#name : #DcItemUserInformation,
	#superclass : #DcItemComplex,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemUserInformation class >> itemType [

	^ Integer readFrom: '50H' base: 16
]

{ #category : #'as yet unclassified' }
DcItemUserInformation >> standard [

	self addItem: DcItemMaxLength new.
	self addItem:
		(DcItemImplementationClass new value: '1.2.276.0.7230010.3.0.3.6.99').
	self addItem: (DcItemImplementationVersionName new value: 'PHICOM_0.1')
]
