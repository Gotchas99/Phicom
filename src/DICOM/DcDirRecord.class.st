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
DcDirRecord >> allEntities [

	| ents  |
	ents := OrderedCollection with: self.
	self lowerEntity ifNotNil: [ :ent | 
		ent records do: [ :rec | ents addAll: rec allEntities ] ].
	^ ents
]

{ #category : #accessing }
DcDirRecord >> at: aKey [

	^ self at: aKey ifAbsent: [ KeyNotFound signalFor: aKey ]
]

{ #category : #accessing }
DcDirRecord >> at: aKey ifAbsent: aZeroArgBlock [

	^ properties detect: [ :el | el keyword = aKey ]ifNone:aZeroArgBlock
]

{ #category : #accessing }
DcDirRecord >> children [
^self lowerEntity records
]

{ #category : #accessing }
DcDirRecord >> entitiesOfType: aTypename [

	^ self lowerEntity entitiesOfType: aTypename 
]

{ #category : #accessing }
DcDirRecord >> file:aDirFile [
file:=aDirFile 
]

{ #category : #inspecting }
DcDirRecord >> inspectionString [

	<inspectorPresentationOrder: -10 title: 'DICOM DirRecord'>
	^ SpTablePresenter new
		  addColumn:
			  ((SpStringTableColumn title: 'Index' evaluated: #displayKey)
				   width: 200);
		  addColumn:
			  (SpStringTableColumn title: 'Field' evaluated: #displayValue);
		  items: properties;
		  yourself
]

{ #category : #accessing }
DcDirRecord >> lowerEntity [

	^ lowerEntity ifNil: [ 
		  file readStreamDo: [ :s | 
			  lowerEntity := DcDirEntity new
				                 file: file;
				                 readFrom: s
				                 atPos: offsetLowerEntity
				                 explicitVR: explicit ]. lowerEntity  ]
]

{ #category : #accessing }
DcDirRecord >> nextRecord [ ^offsetNextRecord
]

{ #category : #printing }
DcDirRecord >> printOn: aStream [
	"super printOn: aStream."

	aStream << 'DR: ' << type << '/' << self size asString
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

{ #category : #accessing }
DcDirRecord >> size [

	^ self lowerEntity records size
]

{ #category : #accessing }
DcDirRecord >> type [ ^type
]
