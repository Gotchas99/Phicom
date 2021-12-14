Class {
	#name : #DcAe,
	#superclass : #Object,
	#instVars : [
		'dimse'
	],
	#classInstVars : [
		'default'
	],
	#category : #'CAs-DICOM-AE'
}

{ #category : #'as yet unclassified' }
DcAe class >> AETitle [

	self subclassResponsibility 
]

{ #category : #accessing }
DcAe class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
DcAe class >> initialize [

	SessionManager default registerUserClassNamed: self name.
self reset
]

{ #category : #accessing }
DcAe class >> reset [

	default := nil
]

{ #category : #initialization }
DcAe class >> startUp: resuming [

	self traceCr: 'DcAe startUp. resuming: ' , resuming printString.
	SessionManager default currentSession addDeferredStartupAction: [ 
		self allSubclassesDo: [:c|c reset]]
]

{ #category : #initialization }
DcAe >> aeTitle [
^self class AETitle 
]

{ #category : #accessing }
DcAe >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAe >> dimse: anObject [

	dimse := anObject
]

{ #category : #initialization }
DcAe >> initialize [ 
self initializeNetwork
]

{ #category : #initialization }
DcAe >> initializeNetwork [

	dimse := DcDimse new.
	dimse ae: self.
]
