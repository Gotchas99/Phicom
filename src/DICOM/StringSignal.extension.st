Extension { #name : #StringSignal }

{ #category : #'*DICOM' }
StringSignal class >> emit: aString [

	| sig |
	sig := self new message: aString.
	sig properties at: 'sender' put: thisContext sender method  name.
	sig emit.
	^ sig
]
