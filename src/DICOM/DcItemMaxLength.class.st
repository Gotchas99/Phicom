Class {
	#name : #DcItemMaxLength,
	#superclass : #DcItemSimple,
	#category : #'DICOM-ACSE'
}

{ #category : #accessing }
DcItemMaxLength class >> itemType [

	^ Integer readFrom: '51H' base: 16
]

{ #category : #initialization }
DcItemMaxLength >> initialize [

	super initialize.
	value := 8192 "or 16384. whatever"
]

{ #category : #writing }
DcItemMaxLength >> myLength [

	^ 4
]

{ #category : #'instance creation' }
DcItemMaxLength >> readItemFrom: stream [

	value := (stream next: 4) unsignedLongAt: 1 bigEndian: true
]

{ #category : #writing }
DcItemMaxLength >> writeOn: stream [
super writeOn: stream.
	stream uint32: value
]
