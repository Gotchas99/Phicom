Class {
	#name : #DcAeDirectory,
	#superclass : #Object,
	#classVars : [
		'NetworkDirectory',
		'OurDirectory'
	],
	#category : #'DICOM-AE'
}

{ #category : #initialization }
DcAeDirectory class >> initialize [
self initializeOurDirectory.
	self initializeNetworkDirectory
]

{ #category : #initialization }
DcAeDirectory class >> initializeNetworkDirectory [

	NetworkDirectory := Dictionary new.
	NetworkDirectory at: 'GINKGO_222' put: #( 'localhost' 1045 ).
	NetworkDirectory at: 'GINKGO_222.IP' put: #( '127.0.0.1' 1045 ).
	NetworkDirectory at: 'DCMRECV' put: #( '127.0.0.1' 1104 )
]

{ #category : #initialization }
DcAeDirectory class >> initializeOurDirectory [

	OurDirectory := Dictionary new.
	DcAe allSubclassesDo: [ :c | OurDirectory at: c AETitle put: c ] 
]

{ #category : #accessing }
DcAeDirectory class >> networkForAET: anAET [

	| tmp addr |
	tmp := NetworkDirectory at: anAET.
	addr := NetNameResolver addressForName: tmp first timeout: 10.
	^ { 
		  addr.
		  tmp second }
]

{ #category : #accessing }
DcAeDirectory class >> ourAET: anAET [

	| tmp |
	tmp := OurDirectory at: anAET.

	^ tmp
]
