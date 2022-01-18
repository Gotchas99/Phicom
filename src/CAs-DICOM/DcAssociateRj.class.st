Class {
	#name : #DcAssociateRj,
	#superclass : #DcAssociateStop,
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #'as yet unclassified' }
DcAssociateRj class >> aeNotrecognized [

	^ self new
		 	result: 1;
				source: 1;
				reasonDiag: 7.
]

{ #category : #'as yet unclassified' }
DcAssociateRj class >> invalidAppContext [

	^self new 		result: 1;
			source: 2;
			reasonDiag: 3.
]

{ #category : #accessing }
DcAssociateRj class >> serviceName [

	^ #aAssociate
]

{ #category : #accessing }
DcAssociateRj class >> type [

	^ 3
]
