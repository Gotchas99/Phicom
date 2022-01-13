"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCAsDICOM,
	#superclass : #PackageManifest,
	#category : #'CAs-DICOM-Manifest'
}

{ #category : #'code-critics' }
ManifestCAsDICOM class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#DcMessage)) #'2021-12-20T09:33:18.229+01:00') )
]
