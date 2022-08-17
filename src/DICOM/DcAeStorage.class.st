Class {
	#name : #DcAeStorage,
	#superclass : #DcAe,
	#category : #'DICOM-AE'
}

{ #category : #'as yet unclassified' }
DcAeStorage class >> AETitle [

	^'PHICOM_ST'
]

{ #category : #initialization }
DcAeStorage class >> initializeCmdTable [

	CmdTable := super initializeCmdTable.
	CmdTable at: 'C-STORE-RQ' put: [ :raw | raw asString trimmed ]. 
	^ CmdTable
]

{ #category : #'as yet unclassified' }
DcAeStorage >> cFindRq: param assoc: anAssoc [

	| rsp |
	rsp := DcSrvParamCFind new createFromResponse: param.
	rsp status: 0.
	dimse responseService: rsp messageType param: rsp forAssoc: anAssoc
]
