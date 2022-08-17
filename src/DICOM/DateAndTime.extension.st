Extension { #name : #DateAndTime }

{ #category : #'*DICOM' }
DateAndTime >> asStringYMDHMS [

	^ String streamContents: [ :aStream | 
		  self printYMDOn: aStream.
		  aStream nextPut: Character space. 
		  self printHMSOn: aStream ]
]
