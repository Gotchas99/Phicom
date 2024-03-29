Class {
	#name : #DcSrvParamCEcho,
	#superclass : #DcSrvParam,
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'as yet unclassified' }
DcSrvParamCEcho class >> messageTypes [

	^ #( 'C-ECHO-RQ' 'C-ECHO-RSP' )
]

{ #category : #converting }
DcSrvParamCEcho >> asMessage [

	| msg |
	msg := super asMessage.
msg addDataSetType .	^ msg
]

{ #category : #creating }
DcSrvParamCEcho >> createFromMessage: aMsg [

	super createFromMessage: aMsg.
	
]

{ #category : #creating }
DcSrvParamCEcho >> createFromRequest: aParam [

	super createFromRequest: aParam.
	self messageType: 'C-ECHO-RQ'.
	self sopClassUid: (DcTable uidAtKeyword: #Verification)
]

{ #category : #creating }
DcSrvParamCEcho >> createFromResponse: aParam [

	super createFromResponse: aParam.
	self messageType: 'C-ECHO-RSP'.
	self sopClassUid: '1.2.840.10008.1.1'
]
