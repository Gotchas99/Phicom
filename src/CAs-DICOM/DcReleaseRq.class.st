Class {
	#name : #DcReleaseRq,
	#superclass : #DcAssociateStop,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcReleaseRq class >> serviceName [

	^ #aRelease
]

{ #category : #accessing }
DcReleaseRq class >> type [

	^ 5
]
