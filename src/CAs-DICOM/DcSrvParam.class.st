Class {
	#name : #DcSrvParam,
	#superclass : #Object,
	#instVars : [
		'messageType',
		'messageId',
		'messageIdResp',
		'sopClassUid',
		'status',
		'dict'
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

{ #category : #converting }
DcSrvParam >> asMessage [

	"messageId messageIdResp sopClassUid status"

	| msg |
	msg := DcMessage new. 
	self messageId ifNotNil: [ :val | 
		msg addCommand: 'MessageID' value: val ].
self 	messageIdResp ifNotNil: [  :val | 
		msg addCommand: 'MessageIDBeingRespondedTo'
				 value: val ].
	msg addCommand:
		 'AffectedSOPClassUID' value: self sopClassUid.
self 	status ifNotNil: [  :val | 
		msg addCommand:  'Status' value: val ].
	msg addCommandField: messageType.
	^ msg
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

	"messageIdResp := aParam messageId"
]

{ #category : #creating }
DcSrvParam >> createFromResponse: aParam [

	messageIdResp := aParam messageId
]

{ #category : #initialization }
DcSrvParam >> initialize [ 
dict:= Dictionary new
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
DcSrvParam >> messageType: aMessageType [

 messageType:=aMessageType
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
