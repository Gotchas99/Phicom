Class {
	#name : #DcUpperLayerServer,
	#superclass : #DcUpperLayer,
	#instVars : [
		'dimses'
	],
	#category : #'CAs-DICOM-UpperLayer'
}

{ #category : #converting }
DcUpperLayerServer >> associate: anAssoc [

	self halt.
]

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> dimseAt: aeTitle [

^	dimses at: aeTitle 
]

{ #category : #'as yet unclassified' }
DcUpperLayerServer >> indication: request forAssoc: anAssoc [

	| dimse response  elements |
	response := request isAssociation
		            ifTrue: [ 
		            DcAcse default indication: request forAssoc: anAssoc ]
		            ifFalse: [ 
			            self halt.
			            elements := OrderedCollection new.
			            request items do: [ :it | elements := it elements ].
			            dimse := anAssoc dimse.
			            dimse indication: request forAssoc: anAssoc ].
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
