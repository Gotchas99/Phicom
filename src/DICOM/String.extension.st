Extension { #name : #String }

{ #category : #'*DICOM' }
String >> even [

	^ self size even
]

{ #category : #'*DICOM' }
String >> padToEven [

	^ self size even
		  ifTrue: [ self ]
		  ifFalse: [ self copyWith:Character space ]
]

{ #category : #'*DICOM' }
String >> padToEvenNull [

	^ self size even
		  ifTrue: [ self ]
		  ifFalse: [ self copyWith: Character null ]
]
