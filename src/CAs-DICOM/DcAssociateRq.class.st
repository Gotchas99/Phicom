Class {
	#name : #DcAssociateRq,
	#superclass : #DcAssociateStart,
	#instVars : [
		'ctxID'
	],
	#category : #'CAs-DICOM-ACSE'
}

{ #category : #accessing }
DcAssociateRq class >> type [ ^1
]

{ #category : #accessing }
DcAssociateRq >> addPresContext: aPresContext [

	|  |
	aPresContext id: self nextCtxID.
	items add: aPresContext
]

{ #category : #adding }
DcAssociateRq >> addStandardItems [

	| pres ui |
	self addItem: DcItemAppContext new.
	pres := DcItemPresContext new.
	pres addItem:(DcItemAbstractSyntax verification ).
		pres addItem:(DcItemTransferSyntax default).
	self addItem: pres.
	ui := DcItemUserInformation new standard.
	self addItem: ui
]

{ #category : #accessing }
DcAssociateRq >> nextCtxID [
^ctxID := ctxID ifNil: [ 1 ] ifNotNil: [ ctxID+2 ]
]
