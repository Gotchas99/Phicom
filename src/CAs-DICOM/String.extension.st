Extension { #name : #String }

{ #category : #'*CAs-DICOM' }
String >> even [

	^ self size even
]

{ #category : #'*CAs-DICOM' }
String >> padToEven [

	^ self size even
		  ifTrue: [ self ]
		  ifFalse: [ self copyWith:Character space ]
]

{ #category : #'*CAs-DICOM' }
String >> padToEvenNull [

	^ self size even
		  ifTrue: [ self ]
		  ifFalse: [ self copyWith: Character null ]
]
