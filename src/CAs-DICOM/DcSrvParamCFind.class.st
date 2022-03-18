Class {
	#name : #DcSrvParamCFind,
	#superclass : #DcSrvParam,
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'as yet unclassified' }
DcSrvParamCFind class >> messageTypes [

	^ #( 'C-FIND-RQ' 'C-FIND-RSP' )
]

{ #category : #creating }
DcSrvParamCFind >> createFromRequest: aParam [

	super createFromRequest: aParam.
	self messageType: 'C-FIND-RSP'.
	self sopClassUid: '1.2.840.10008.1.1'
]

{ #category : #creating }
DcSrvParamCFind >> createFromResponse: aParam [

	super createFromResponse: aParam.
	self messageType: 'C-FIND-RSP'.
	self sopClassUid: '1.2.840.10008.5.1.4.1.2.2.1'
]
