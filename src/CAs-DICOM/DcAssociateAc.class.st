Class {
	#name : #DcAssociateAc,
	#superclass : #DcAssociateStart,
	#instVars : [
		'rq'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcAssociateAc class >> type [

	^ 2
]

{ #category : #'as yet unclassified' }
DcAssociateAc >> invalid: resultCode [

	self halt.
]

{ #category : #accessing }
DcAssociateAc >> rq [

	^ rq
]

{ #category : #accessing }
DcAssociateAc >> rq: anObject [

	rq := anObject.
	items add: rq items first.
	version := rq version.
	self calledAET: rq calledAET .
	self callingAET: rq callingAET .
]
