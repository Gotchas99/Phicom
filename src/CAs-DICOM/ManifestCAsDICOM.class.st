"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCAsDICOM,
	#superclass : #PackageManifest,
	#category : #'CAs-DICOM-Manifest'
}

{ #category : #'code-critics' }
ManifestCAsDICOM class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DcAe #indication:with:for: #false)) #'2022-02-15T16:29:30.121+01:00') #(#(#RGMethodDefinition #(#DcAe #confirmation:with:for: #false)) #'2022-02-17T14:24:11.301+01:00') )
]

{ #category : #'code-critics' }
ManifestCAsDICOM class >> ruleCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#DcMessage)) #'2021-12-20T09:33:18.229+01:00') #(#(#RGMethodDefinition #(#DcDimse #fragsFromElements: #false)) #'2022-02-03T14:54:09.497+01:00') )
]
