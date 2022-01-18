Class {
	#name : #DcSrvParam,
	#superclass : #Object,
	#instVars : [
		'messageType',
		'messageId',
		'messageIdResp',
		'sopClassUid',
		'status'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'instance creation' }
DcSrvParam class >> classForCmd: aCmd [

	^ self allSubclasses detect: [ :sub | sub handlesCmd: aCmd ]
]

{ #category : #'instance creation' }
DcSrvParam class >> fromMessage: aMsg [

	| cmd class |
	cmd := DcDimse cmdAt: aMsg cmd.
	class := self classForCmd: cmd.
	^class new createFromMessage:aMsg
]

{ #category : #'instance creation' }
DcSrvParam class >> handlesCmd: aCmd [

	^ self messageTypes includes: aCmd
]

{ #category : #initialization }
DcSrvParam class >> initialize [
]

{ #category : #'as yet unclassified' }
DcSrvParam class >> messageTypes [

	self subclassResponsibility 
]

{ #category : #creating }
DcSrvParam >> createFromMessage: aMsg [

	| cmds |
	cmds := aMsg cmdDict.
	messageId := cmds at: #MessageID.
	messageIdResp := cmds
		                 at: #MessageIDBeingRespondedTo
		                 ifAbsent: [ nil ].
	sopClassUid := cmds at: #AffectedSOPClassUID.
	status := cmds at: #Status ifAbsent: [ nil ]
]

{ #category : #creating }
DcSrvParam >> createFromRequest: aParam [

	messageIdResp:= aParam messageId
]

{ #category : #accessing }
DcSrvParam >> messageId [

	^ messageId
]

{ #category : #accessing }
DcSrvParam >> messageId: anObject [

	messageId := anObject
]

{ #category : #accessing }
DcSrvParam >> messageIdResp [

	^ messageIdResp
]

{ #category : #accessing }
DcSrvParam >> messageIdResp: anObject [

	messageIdResp := anObject
]

{ #category : #accessing }
DcSrvParam >> messageType [ ^messageType
]

{ #category : #accessing }
DcSrvParam >> sopClassUid [

	^ sopClassUid
]

{ #category : #accessing }
DcSrvParam >> sopClassUid: anObject [

	sopClassUid := anObject
]

{ #category : #accessing }
DcSrvParam >> status [

	^ status
]

{ #category : #accessing }
DcSrvParam >> status: anObject [

	status := anObject
]
