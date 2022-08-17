Class {
	#name : #DcReleaseRq,
	#superclass : #DcAssociateStop,
	#category : #'DICOM-ACSE'
}

{ #category : #accessing }
DcReleaseRq class >> serviceName [

	^ #aRelease
]

{ #category : #accessing }
DcReleaseRq class >> type [

	^ 5
]
