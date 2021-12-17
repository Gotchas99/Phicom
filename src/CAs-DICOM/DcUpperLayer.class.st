Class {
	#name : #DcUpperLayer,
	#superclass : #Object,
	#classVars : [
		'ServiceMap'
	],
	#classInstVars : [
		'default'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #accessing }
DcUpperLayer class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
DcUpperLayer class >> initialize [
self initializeServiceMap
	
]

{ #category : #initialization }
DcUpperLayer class >> initializeServiceMap [

	ServiceMap := Dictionary new.
	DcPDU allSubclassesDo: [ :c | ServiceMap at:c type put:c serviceName ]
]

{ #category : #accessing }
DcUpperLayer class >> reset [

	default := nil
]

{ #category : #initialization }
DcUpperLayer class >> serviceForType: aTypeId [

^
		ServiceMap at: aTypeId
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

{ #category : #initialization }
DcUpperLayer >> serviceForType: aTypeId [

	^ ServiceMap at: aTypeId
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> servicingAE: anAE [

	
]
