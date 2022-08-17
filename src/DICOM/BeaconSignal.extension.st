Extension { #name : #BeaconSignal }

{ #category : #'*DICOM' }
BeaconSignal >> printOneLineOn: stream [

	stream
		nextPutAll: self timestamp asString;
		space;
		nextPutAll: (properties at:#sender ifAbsent: [self class name]);
		space.
	self printOneLineContentsOn: stream
]

{ #category : #'*DICOM' }
BeaconSignal >> printOneLineOn_old: stream [

	stream
		nextPutAll: self timestamp asString;
		space;
		nextPutAll: self class name;
		space.
	self printOneLineContentsOn: stream
]
