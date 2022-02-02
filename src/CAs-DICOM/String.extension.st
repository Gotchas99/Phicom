Extension { #name : #String }

{ #category : #'*CAs-DICOM' }
String >> isEven [

	^self size isEven 
]

{ #category : #'*CAs-DICOM' }
String >> padToEven [

	^ self size isEven
		  ifTrue: [ self ]
		  ifFalse: [ self,' ' ]
]

{ #category : #'*CAs-DICOM' }
String >> padToEvenNull [

	^ self size isEven
		  ifTrue: [ self ]
		  ifFalse: [ self , Character null ]
]
