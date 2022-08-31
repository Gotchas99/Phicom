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
			package: 'SQLite3'
			with: [ spec repository: 'github://pharo-rdbms/Pharo-SQLite3/src' ];
			package: 'XML-XMLParser'
			with: [ 
				spec repository: 'github://pharo-contributions/XML-XMLParser/src' ];
			package: 'DICOM'
			with: [ spec requires: #( 'XML-XMLParser' ) ].
			"package: 'DICOM-Core' with: [ spec requires: #( 'DICOM-Util' ) ];
			package: 'DICOM-File'
			with: [ spec requires: #( 'DICOM-Core' 'SQLite3' ) ];
			package: 'DICOM-Net' with: [ spec requires: #( 'DICOM-Core' ) ];
			package: 'DICOM-UpperLayer'
			with: [ spec requires: #( 'DICOM-Net' ) ];
			package: 'DICOM-ACSE'
			with: [ spec requires: #( 'DICOM-UpperLayer' ) ];
			package: 'DICOM-Dimse'
			with: [ spec requires: #( 'DICOM-UpperLayer' ) ];
			package: 'DICOM-AE'
			with: [ spec requires: #( 'DICOM-ACSE' 'DICOM-Dimse' ) ]."
		spec
			"group: 'Core' with: #( 'DICOM-Core' );"
			group: 'default' with: #( 'DICOM' ) ]
]
