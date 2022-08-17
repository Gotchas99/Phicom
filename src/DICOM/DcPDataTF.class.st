Class {
	#name : #DcPDataTF,
	#superclass : #DcPDU,
	#category : #'DICOM-Net'
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
	super initialize
]

{ #category : #testing }
DcPDataTF >> isAssociation [

	^ false
]

{ #category : #reading }
DcPDataTF >> readPduFrom: stream [

	| pdv |
	[ stream atEnd ] whileFalse: [ 
		pdv := DcPDV readFrom: stream.
		items add: pdv ]
]

{ #category : #writing }
DcPDataTF >> writeOn: stream [

	super writeOn: stream.
	self items do: [ :item | item writeOn: stream ]
]
