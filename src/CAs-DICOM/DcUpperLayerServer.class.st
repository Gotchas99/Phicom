Class {
	#name : #DcUpperLayerServer,
	#superclass : #DcUpperLayer,
	#instVars : [
		'dimses'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> dimseAt: aeTitle [

^	dimses at: aeTitle 
]

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> indication: pdu forAssoc: anAssoc [

	| dimse response service |
	service := self serviceForType: pdu type.
	response := pdu isAssociation
		            ifTrue: [ 
		         						   DcAcse default indication: pdu forAssoc: anAssoc ]
		            ifFalse: [ 
			            dimse := anAssoc dimse.
			            dimse
				            indicationService: service
				            param: pdu items
				            forAssoc: anAssoc ].
	^ response
]

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> initialize [

	dimses:=Dictionary new.
]

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> registerDimse: aDimse for: aeTitle [

	dimses at: aeTitle put: aDimse
]