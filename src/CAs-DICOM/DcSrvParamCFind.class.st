Class {
	#name : #DcSrvParamCFind,
	#superclass : #DcSrvParam,
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'as yet unclassified' }
DcSrvParamCFind class >> messageTypes [

	^ #( 'C-FIND-RQ' 'C-FIND-RSP' )
]
