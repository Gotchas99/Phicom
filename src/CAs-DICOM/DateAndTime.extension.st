Extension { #name : #DateAndTime }

{ #category : #'*CAs-DICOM' }
DateAndTime >> asStringYMDHMS [

	^ String streamContents: [ :aStream | 
		  self printYMDOn: aStream.
		  aStream nextPut: Character space. 
		  self printHMSOn: aStream ]
]
