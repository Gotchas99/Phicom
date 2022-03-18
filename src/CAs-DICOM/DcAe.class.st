Class {
	#name : #DcAe,
	#superclass : #Object,
	#instVars : [
		'dimse',
		'assocs'
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

	self traceCr: self name, ' startUp. resuming: ' , resuming printString.
	SessionManager default currentSession addDeferredStartupAction: [ 
		self allSubclassesDo: [ :c | c reset ] ]
]

{ #category : #accessing }
DcAe >> aeTitle [
^self class AETitle 
]

{ #category : #services }
DcAe >> cEchoRq: param assoc: anAssoc [

	| rsp |
	rsp := DcSrvParamCEcho new createFromResponse: param.
	rsp status: 0.
	dimse responseService: rsp messageType param: rsp forAssoc: anAssoc
]

{ #category : #services }
DcAe >> cEchoRsp: param assoc: anAssoc [

	|  orig |
	orig := anAssoc receiveOutstandingID: param messageIdResp.
	self doneWithAssoc: anAssoc
]

{ #category : #dispatch }
DcAe >> confirmation: cmd with: param for: anAssoc [

	| method |
	"anAssoc lastKnownMsgId: param messageId."
	method := self methodFromCmd: cmd.
	^ self perform: method with: param with: anAssoc
]

{ #category : #accessing }
DcAe >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAe >> dimse: anObject [

	dimse := anObject
]

{ #category : #services }
DcAe >> doneWithAssoc: anAssoc [
anAssoc isEmpty ifTrue:
[self releaseAssoc: anAssoc .
]
]

{ #category : #services }
DcAe >> echo: anAETitle [

	| assoc req |
	assoc := self setupAssoc: anAETitle.
	req := DcSrvParamCEcho new createFromRequest: nil.
	req messageId: assoc nextMsgId.
	dimse requestService: req messageType param: req forAssoc: assoc.
	"self releaseAssoc: assoc"
]

{ #category : #dispatch }
DcAe >> indication: cmd with: param for: anAssoc [

	| method |
	anAssoc lastKnownMsgId: param messageId.
	method := self methodFromCmd: cmd.
	self flag:'release assoc here?'.	^ self perform: method with: param with: anAssoc.

]

{ #category : #initialization }
DcAe >> initialize [ 
self initializeNetwork
]

{ #category : #initialization }
DcAe >> initializeNetwork [

	dimse := DcDimse new.
	dimse ae: self.
	assocs:= Dictionary new.
]

{ #category : #private }
DcAe >> methodFromCmd: cmd [

	"cmd := 'C-ECHO-RQ'."

	| rq3 rq4 rq5 rq6 rq7 |
	rq3 := $- split: cmd asLowercase.
	rq4 := rq3 allButFirst collect: [ :each | each capitalized ].
	rq5 := rq3 first asArray , rq4.
	rq6 := '' join: rq5.
	rq7 := (rq6 , ':assoc:') asSymbol.
	^ rq7
]

{ #category : #services }
DcAe >> releaseAssoc: anAssoc [
DcAcse default releaseAssoc: anAssoc param: nil.
	assocs removeKey: anAssoc remoteAETitle  ifAbsent: [ self traceCr: 'assoc not found when releasing' ]
]

{ #category : #private }
DcAe >> setupAssoc: anAETitle [

	| assoc paramDict |
	assoc := DcAssociation new.
	assoc ae: self.
	assoc remoteAETitle: anAETitle.
	assoc dimse: self dimse.
	paramDict := Dictionary new.
	assoc
		addOfferedPresCtxs: #Verification
		tsn: #( #ImplicitVRLittleEndian ).
	DcAcse default connectAssoc: assoc param: paramDict.
	assocs at: anAETitle put: assoc.
	^ assoc
]
