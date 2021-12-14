Class {
	#name : #DcUpperLayer,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #accessing }
DcUpperLayer class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
DcUpperLayer class >> reset [

	default := nil
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> associate [
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> associateAET: anAET [ 

	^ DcAssociation new
		  aet: anAET
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> associateAET: anAET ip: ip port: port [

	^ DcAssociation new aet: anAET;ip: ip ;port:port
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> servicingAE: anAE [

	
]
