Class {
	#name : #DcDirRecord,
	#superclass : #Object,
	#instVars : [
		'file',
		'offsetLowerEntity',
		'type',
		'properties',
		'lowerEntity',
		'explicit',
		'offsetNextRecord'
	],
	#category : #'DICOM-File'
}

{ #category : #accessing }
DcDirRecord >> file:aDirFile [
file:=aDirFile 
]

{ #category : #accessing }
DcDirRecord >> lowerEntity [

	^ lowerEntity ifNil: [ 
		  file readStreamDo: [ :s | 
			  lowerEntity := DcDirEntity new file:file;
				                 readFrom: s
				                 atPos: offsetLowerEntity
				                 explicitVR: explicit ] ]
]

{ #category : #accessing }
DcDirRecord >> nextRecord [ ^offsetNextRecord
]

{ #category : #printing }
DcDirRecord >> printOn: aStream [

	"super printOn: aStream."

	aStream << 'DR: ' << type
]

{ #category : #'instance creation' }
DcDirRecord >> readFrom: aStream atPos: startPos explicitVR: explicitVR [

	| els inUse |
	explicit := explicitVR.
	aStream position: startPos.
	els := DcSqItem from: aStream explicitVR: explicitVR.
	offsetNextRecord := els first value.
	inUse := els second value.
	offsetLowerEntity := els third value.
	type := els fourth value.
	properties := els allButFirst: 4
]

{ #category : #printing }
DcDirRecord >> type [ ^type
]
