Class {
	#name : #DcSrvParamCEcho,
	#superclass : #DcSrvParam,
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'as yet unclassified' }
DcSrvParamCEcho class >> messageTypes [

	^ #( 'C-ECHO-RQ' 'C-ECHO-RSP' )
]

{ #category : #creating }
DcSrvParamCEcho >> createFromMessage: aMsg [

	super createFromMessage: aMsg.
	
]

{ #category : #creating }
DcSrvParamCEcho >> createFromRequest: aParam [

	super createFromRequest: aParam.
	messageType:='C-ECHO-RSP'
]
