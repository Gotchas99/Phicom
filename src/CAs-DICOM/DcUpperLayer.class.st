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

{ #category : #initialization }
DcUpperLayer >> serviceForType: aTypeId [

	^ ServiceMap at: aTypeId
]
