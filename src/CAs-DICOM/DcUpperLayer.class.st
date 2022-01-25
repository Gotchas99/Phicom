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
DcUpperLayer >> associateAET: anAET [ 

	^ DcAssociation new
		  aet: anAET
]

{ #category : #'as yet unclassified' }
DcUpperLayer >> associateAET: anAET ip: ip port: port [

	self
		deprecated: 'Use #associateAET: instead'
		on: '25 January 2022'
		in:
		'Pharo-9.0.0+build.1565.sha.38c49c239a1ccdaeb4f20be047e335d480f0dc59 (64 Bit)'.

	^ DcAssociation new
		  aet: anAET;
		  ip: ip;
		  port: port
]

{ #category : #initialization }
DcUpperLayer >> serviceForType: aTypeId [

	^ ServiceMap at: aTypeId
]
