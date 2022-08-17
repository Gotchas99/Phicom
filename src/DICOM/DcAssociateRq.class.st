Class {
	#name : #DcAssociateRq,
	#superclass : #DcAssociateStart,
	#category : #'DICOM-ACSE'
}

{ #category : #accessing }
DcAssociateRq class >> type [ ^1
]

{ #category : #accessing }
DcAssociateRq >> addPresContext: aPresContext [

"	aPresContext ctxID: self nextCtxID."
	items add: aPresContext
]

{ #category : #adding }
DcAssociateRq >> addStandardItems [

	| pres ui |
	self addItem: DcItemAppContext new.
	"pres := DcItemPresContext new.
	pres addItem: DcItemAbstractSyntax verification.
	pres addItem: DcItemTransferSyntax default.
	self addPresContext: pres."
	ui := DcItemUserInformation new standard.
	self addItem: ui
]
