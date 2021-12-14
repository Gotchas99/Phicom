Class {
	#name : #DcItemPresContext,
	#superclass : #DcItemComplex,
	#instVars : [
		'ctxID',
		'resultReason'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcItemPresContext class >> itemType [

	^ Integer readFrom: '20H' base: 16
]

{ #category : #'as yet unclassified' }
DcItemPresContext >> abstractSyntax [
]

{ #category : #accessing }
DcItemPresContext >> ctxID [

	^ ctxID
]

{ #category : #accessing }
DcItemPresContext >> ctxID: anObject [

	ctxID := anObject
]

{ #category : #initialization }
DcItemPresContext >> initialize [

	super initialize.
		ctxID := 1.
	resultReason := 0
]

{ #category : #accessing }
DcItemPresContext >> myLength [

	^ 1+1+1+1
]

{ #category : #'instance creation' }
DcItemPresContext >> readMyFieldsFrom: stream [

	ctxID := stream next.
	stream skip: 1.
	resultReason := stream next.
	stream skip: 1.

]

{ #category : #accessing }
DcItemPresContext >> resultReason [

	^ resultReason
]

{ #category : #accessing }
DcItemPresContext >> resultReason: anObject [

	resultReason := anObject
]

{ #category : #writing }
DcItemPresContext >> writeMyFieldsOn: stream [


	stream
		uint8: ctxID;
		uint8: 0;
		uint8: resultReason;
		uint8: 0.
	
]
