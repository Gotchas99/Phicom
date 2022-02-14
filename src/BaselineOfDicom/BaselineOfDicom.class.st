Class {
	#name : #BaselineOfDicom,
	#superclass : #BaselineOf,
	#category : #BaselineOfDicom
}

{ #category : #baselines }
BaselineOfDicom >> baseline: spec [

	"requires: Beacon-Core"

	<baseline>
	spec for: #common do: [ 
		spec blessing: #baseline.
		spec package: 'Dicom-Core'.
		";
			""Going from Dicom model to richText""package:
				'Pillar-ExporterRichText'
			with: [ spec requires: #( 'Dicom-Core' ) ]"
		spec group: 'default' with: #( 'Core' ) ]
]
