Class {
	#name : #BaselineOfDicom,
	#superclass : #BaselineOf,
	#category : #BaselineOfDicom
}

{ #category : #baselines }
BaselineOfDicom >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec blessing: #baseline.
		spec
			baseline: 'SQLite3'
			with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ];
			baseline: 'XMLParser' 
			with: [ 
				spec repository: 'github://pharo-contributions/XML-XMLParser/src' ];
			package: 'DICOM' with: [ spec requires: #( 'XMLParser' ) ].
		spec group: 'default' with: #( 'DICOM' ) ]
]
