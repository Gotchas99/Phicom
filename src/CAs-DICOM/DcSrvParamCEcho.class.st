Class {
	#name : #DcSrvParamCEcho,
	#superclass : #DcSrvParam,
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'as yet unclassified' }
DcSrvParamCEcho class >> messageTypes [

	^ #( 'C-ECHO-RQ' 'C-ECHO-RSP' )
]

{ #category : #'as yet unclassified' }
DcSrvParamCEcho >> createFromMessage: aMsg [

	super createFromMessage: aMsg.
	
]
