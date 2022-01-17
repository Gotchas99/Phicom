Class {
	#name : #DcSrvParam,
	#superclass : #Object,
	#instVars : [
		'messageId',
		'messageIdResp',
		'sopClassUid',
		'status'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'instance creation' }
DcSrvParam class >> classForCmd: aCmd [

^	self allSubclasses detect:[:sub|sub handles:aCmd].
]

{ #category : #'instance creation' }
DcSrvParam class >> fromMessage: aMsg [

	| cmd class |
	cmd := DcDimse cmdAt: aMsg cmd.
	class := self classForCmd: cmd.
	^class new createFromMessage:aMsg
]

{ #category : #'instance creation' }
DcSrvParam class >> handles: aCmd [

^	self messageTypes includes: aCmd
]

{ #category : #initialization }
DcSrvParam class >> initialize [
]

{ #category : #'as yet unclassified' }
DcSrvParam class >> messageTypes [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
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
