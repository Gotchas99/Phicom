Class {
	#name : #DcSRvalueUIDRef,
	#superclass : #DcSRvalueRel,
	#instVars : [
		'uid'
	],
	#category : #'DICOM-SR'
}

{ #category : #'as yet unclassified' }
DcSRvalueUIDRef class >> valueType [

	^ 'UIDREF'
]

{ #category : #'instance creation' }
DcSRvalueUIDRef >> from: elementList [


	super from: elementList.
	uid := self at: 'UID' inList: elementList
]