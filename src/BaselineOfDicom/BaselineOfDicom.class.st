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
			package: 'CAs-DICOM-Util';
			package: 'CAs-DICOM-Core' with: [ spec requires: #( 'CAs-DICOM-Util' ) ];
			package: 'CAs-DICOM-File' with: [ spec requires: #( 'CAs-DICOM-Core' ) ];
			package: 'CAs-DICOM-Net' with: [ spec requires: #( 'CAs-DICOM-Core' ) ];
			package: 'CAs-DICOM-UpperLayer'
			with: [ spec requires: #( 'CAs-DICOM-Net' ) ];
			package: 'CAs-DICOM-ACSE'
			with: [ spec requires: #( 'CAs-DICOM-UpperLayer' ) ];
			package: 'CAs-DICOM-Dimse'
			with: [ spec requires: #( 'CAs-DICOM-UpperLayer' ) ];
			package: 'CAs-DICOM-AE'
			with: [ spec requires: #( 'CAs-DICOM-ACSE' 'CAs-DICOM-Dimse' ) ].
		spec
			group: 'Core' with: #( 'CAs-DICOM-Core' );
			group: 'default' with: #( 'CAs-DICOM-AE' ) ]
]
