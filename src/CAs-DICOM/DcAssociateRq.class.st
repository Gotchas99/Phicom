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

{ #category : #'as yet unclassified' }
DcAssociateRq >> getPresentationContexts [

	| presCtxs |
	presCtxs := items
		            select: [ :it | it itemType = DcItemPresContext itemType ]
		          	.^ presCtxs 
]

{ #category : #accessing }
DcAssociateRq >> initialize [

	super initialize.
	"ctxID := 1"
	"	presContexts := OrderedCollection new "
]

{ #category : #accessing }
DcAssociateRq >> nextCtxID [
^ctxID := ctxID ifNil: [ 1 ] ifNotNil: [ ctxID+2 ]
]

{ #category : #'as yet unclassified' }
DcAssociateRq >> validateAppContext [

	| appCtx |
	appCtx := items detect: [ :it | it itemType =DcItemAppContext itemType  ] ifNone: [ ^ false ].
	^ appCtx isValid
]
