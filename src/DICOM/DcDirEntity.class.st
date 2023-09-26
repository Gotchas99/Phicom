Class {
	#name : #DcDirEntity,
	#superclass : #Object,
	#instVars : [
		'file',
		'records',
		'explicit'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcDirEntity >> entitiesOfType: aTypename [

	| tmp |
	tmp := records select: [ :r | r type = aTypename ]. 
	^ tmp
]

{ #category : #accessing }
DcDirEntity >> file:aDirFile [
file:=aDirFile 
]

{ #category : #printing }
DcDirEntity >> printOn: aStream [

 aStream << self type 
]

{ #category : #'instance creation' }
DcDirEntity >> readFrom: aStream atPos: startPos explicitVR: explicitVR [

	| newRec recordPos |
	explicit := explicitVR.
	recordPos := startPos.
	records := OrderedCollection new.
	[ recordPos = 0 ] whileFalse: [ 
		newRec := DcDirRecord new
			          file: file;
			          readFrom: aStream
			          atPos: recordPos
			          explicitVR: explicitVR.
		recordPos := newRec nextRecord.
		records add: newRec ]
]

{ #category : #printing }
DcDirEntity >> recordTypes [

	| types |
	records isEmpty ifTrue: [ ^ 'EMPTY' ].
	types := records collect: [ :rec | rec type ].
^	types asSet sorted 
]

{ #category : #accessing }
DcDirEntity >> records [ ^records 

]

{ #category : #printing }
DcDirEntity >> type [

	| types |
	records isEmpty ifTrue: [ ^ 'EMPTY' ].
	types := records collect: [ :rec | rec type ].
	(types asSet size >1)ifTrue:[^'MIXED'].^types first
]
