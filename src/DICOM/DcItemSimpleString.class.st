Class {
	#name : #DcItemSimpleString,
	#superclass : #DcItemSimple,
	#category : #'DICOM-ACSE'
}

{ #category : #'instance creation' }
DcItemSimpleString >> readItemFrom: stream [

	value := stream upToEnd asString
]

{ #category : #writing }
DcItemSimpleString >> writeOn: stream [

	super writeOn: stream.
	stream nextPutAll: value
]
