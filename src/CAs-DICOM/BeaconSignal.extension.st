Extension { #name : #BeaconSignal }

{ #category : #'*CAs-DICOM' }
BeaconSignal >> printOneLineOn: stream [

	stream
		nextPutAll: self timestamp asString;
		space;
		nextPutAll: (properties at:#sender ifAbsent: [self class name]);
		space.
	self printOneLineContentsOn: stream
]

{ #category : #'*CAs-DICOM' }
BeaconSignal >> printOneLineOn_old: stream [

	stream
		nextPutAll: self timestamp asString;
		space;
		nextPutAll: self class name;
		space.
	self printOneLineContentsOn: stream
]
