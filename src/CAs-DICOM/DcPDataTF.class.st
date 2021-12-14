Class {
	#name : #DcPDataTF,
	#superclass : #DcPDU,
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcPDataTF class >> type [

	^ 4
]

{ #category : #initialization }
DcPDataTF >> initialize [

	super initialize
.	items := OrderedCollection new
]

{ #category : #testing }
DcPDataTF >> isAssociation [

	^ false
]

{ #category : #'instance creation' }
DcPDataTF >> readPduFrom: stream [

	| it |
	[ stream atEnd ] whileFalse: [ 
		it := DcPDV readFrom: stream.
		items add: it ]
]
