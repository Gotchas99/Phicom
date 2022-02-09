Class {
	#name : #DcReleaseRp,
	#superclass : #DcAssociateStop,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcReleaseRp class >> serviceName [

	^ #aRelease
]

{ #category : #accessing }
DcReleaseRp class >> type [

	^ 6
]

{ #category : #initialization }
DcReleaseRp >> initialize [ 
super initialize .
source:=2.
]
