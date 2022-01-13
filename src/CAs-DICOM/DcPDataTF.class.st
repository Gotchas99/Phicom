Class {
	#name : #DcPDataTF,
	#superclass : #DcPDU,
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcPDataTF class >> serviceName [

	^ #pData
]

{ #category : #accessing }
DcPDataTF class >> type [

	^ 4
]

{ #category : #initialization }
DcPDataTF >> initialize [

	super initialize.
	
]

{ #category : #testing }
DcPDataTF >> isAssociation [

	^ false
]

{ #category : #'instance creation' }
DcPDataTF >> readPduFrom: stream [

	| pdv |
	[ stream atEnd ] whileFalse: [ 
		pdv := DcPDV readFrom: stream.
		items add: pdv ]
]
