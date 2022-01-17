Class {
	#name : #DcAe,
	#superclass : #Object,
	#instVars : [
		'dimse'
	],
	#classInstVars : [
		'default',
		'CmdTable'
	],
	#category : #'CAs-DICOM-AE'
}

{ #category : #accessing }
DcAe class >> AETitle [

	self subclassResponsibility 
]

{ #category : #initialization }
DcAe class >> CmdTable [

^	CmdTable 
]

{ #category : #accessing }
DcAe class >> default [

	^ default ifNil: [ default := self new ]
]

{ #category : #initialization }
DcAe class >> initialize [

	SessionManager default registerUserClassNamed: self name.
	self reset.
	self initializeCmdTable.
	self allSubclassesDo: [ :c | c initialize ]
]

{ #category : #initialization }
DcAe class >> initializeCmdTable [

	CmdTable := Dictionary new.
	CmdTable
		at: 'C-ECHO-RQ'
		put:#cEchoRq:assoc: .
		"put: [ :param :anAssoc | self cEchoRq: param assoc: anAssoc ]."
	^ CmdTable
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

{ #category : #'as yet unclassified' }
DcAe >> cEchoRq:param assoc:anAssoc [
self halt.
]

{ #category : #accessing }
DcAe >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAe >> dimse: anObject [

	dimse := anObject
]

{ #category : #'as yet unclassified' }
DcAe >> indication: cmd with: param for: anAssoc [

	| method |
	self halt.
	method:= self class CmdTable at: cmd.
	^ (self perform: method with: param with: anAssoc)
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
