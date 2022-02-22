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
			package: 'Dicom-Util';
			package: 'Dicom-Core'
			with: [ spec requires: #( 'Dicom-Util' 'Beacon-Core' ) ];
			package: 'Dicom-File' with: [ spec requires: #( 'Dicom-Core' ) ];
			package: 'Dicom-Net' with: [ spec requires: #( 'Dicom-Core' ) ];
			package: 'Dicom-UpperLayer'
			with: [ spec requires: #( 'Dicom-Net' ) ];
			package: 'Dicom-ACSE'
			with: [ spec requires: #( 'Dicom-UpperLayer' ) ];
			package: 'Dicom-Dimse'
			with: [ spec requires: #( 'Dicom-UpperLayer' ) ];
			package: 'Dicom-AE'
			with: [ spec requires: #( 'Dicom-ACSE' 'Dicom-Dimse' ) ].
		spec
			group: 'Core' with: #( 'Dicom-Core' );
			group: 'default' with: #( 'Dicom-AE' ) ]
]
