Class {
	#name : #DcItemPresContextAC,
	#superclass : #DcItemPresContext,
	#instVars : [
		'resultReason'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcItemPresContextAC class >> itemType [

	^ Integer readFrom: '21H' base: 16
]

{ #category : #initialization }
DcItemPresContextAC >> initialize [

	super initialize.
	resultReason := 0
]

{ #category : #'instance creation' }
DcItemPresContextAC >> readMyFieldsFrom: stream [

	ctxID := stream next.
	stream skip: 1.
	resultReason := stream next.
	stream skip: 1
]

{ #category : #accessing }
DcItemPresContextAC >> resultReason [

	^ resultReason
]

{ #category : #accessing }
DcItemPresContextAC >> resultReason: anObject [

	resultReason := anObject
]

{ #category : #writing }
DcItemPresContextAC >> writeMyFieldsOn: stream [

	stream
		uint8: ctxID;
		uint8: 0;
		uint8: resultReason;
		uint8: 0
]
