Class {
	#name : #DcViewer,
	#superclass : #SpApplication,
	#category : #'DICOM-Ui'
}

{ #category : #examples }
DcViewer class >> applicationName [

	^ 'new dicom app'
]

{ #category : #examples }
DcViewer class >> run [

	<example>
	self new run
]

{ #category : #accessing }
DcViewer >> start [

	(self new: DcPresenterMain) open
]
