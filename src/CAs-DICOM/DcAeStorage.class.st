Class {
	#name : #DcAeStorage,
	#superclass : #DcAe,
	#category : #'CAs-DICOM-AE'
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
