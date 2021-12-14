Class {
	#name : #DcAssociateStop,
	#superclass : #DcPDU,
	#instVars : [
		'result',
		'source',
		'reasonDiag'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #initialization }
DcAssociateStop >> initialize [

	super initialize.
	reasonDiag :=1.
	
]

{ #category : #writing }
DcAssociateStop >> myLength [

	^ 1+1+1+1
]

{ #category : #'instance creation' }
DcAssociateStop >> readPduFrom: stream [

	stream skip: 1.
	result := stream next.	source := stream next.	reasonDiag  := stream next.
]

{ #category : #accessing }
DcAssociateStop >> reasonDiag [

	^ reasonDiag
]

{ #category : #accessing }
DcAssociateStop >> reasonDiag: anObject [

	reasonDiag := anObject
]

{ #category : #accessing }
DcAssociateStop >> result [

	^ result
]

{ #category : #accessing }
DcAssociateStop >> result: anObject [

	result := anObject
]

{ #category : #accessing }
DcAssociateStop >> source [

	^ source
]

{ #category : #accessing }
DcAssociateStop >> source: anObject [

	source := anObject
]

{ #category : #writing }
DcAssociateStop >> writeOn: stream [

	super writeOn: stream.

	stream
		uint8: 0;
		uint8: result ;
		uint8: source ;
		uint8: reasonDiag 
]
