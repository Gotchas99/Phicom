Class {
	#name : #DcUpperLayerServer,
	#superclass : #DcUpperLayer,
	#instVars : [
		'dimses'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #accessing }
DcUpperLayerServer >> dimseAt: aeTitle [

^	dimses at: aeTitle 
]

{ #category : #services }
DcUpperLayerServer >> indication: pdu forAssoc: anAssoc [

	| response service |
	response := pdu isAssociation
		            ifTrue: [ 
		            DcAcse default indication: pdu forAssoc: anAssoc ]
		            ifFalse: [ service := self serviceForType: pdu type.
				            anAssoc dimse
				            indicationService: service
				            param: pdu items
				            forAssoc: anAssoc ].
	^ response
]

{ #category : #initialization }
DcUpperLayerServer >> initialize [

	dimses:=Dictionary new.
]

{ #category : #accessing }
DcUpperLayerServer >> registerDimse: aDimse for: aeTitle [

	dimses at: aeTitle put: aDimse
]
