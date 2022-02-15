Class {
	#name : #DcFileMeta,
	#superclass : #Object,
	#instVars : [
		'version',
		'meta',
		'preAmble',
		'prefix'
	],
	#category : #'CAs-DICOM-File'
}

{ #category : #registry }
DcFileMeta class >> initialize [

"	self initializeRegistry"
]

{ #category : #registry }
DcFileMeta class >> initializeRegistry [

	self deprecated: 'init görs i dctable'.
	"Registry := DcTable new text: self registryText cols: 5"
]

{ #category : #'as yet unclassified' }
DcFileMeta class >> readMetaFrom: s [

	^ self new readMetaFrom: s  
]

{ #category : #registry }
DcFileMeta class >> registry [
self deprecated: 'sköts i dctable'.
	"^ Registry"
]

{ #category : #registry }
DcFileMeta class >> registryText [
self deprecated: 'sköts i dctable'
	.
	^ 'Tag

Name

Keyword

VR

VM


(0002,0000)

File Meta Information Group Length

File​Meta Information​Group​Length

UL

1


(0002,0001)

File Meta Information Version

File​Meta​Information​Version

OB

1


(0002,0002)

Media Storage SOP Class UID

Media​Storage​SOP​Class​UID

UI

1


(0002,0003)

Media Storage SOP Instance UID

Media​Storage​SOP​Instance​UID

UI

1


(0002,0010)

Transfer Syntax UID

Transfer​Syntax​UID

UI

1


(0002,0012)

Implementation Class UID

Implementation​Class​UID

UI

1


(0002,0013)

Implementation Version Name

Implementation​Version​Name

SH

1


(0002,0016)

Source Application Entity Title

Source​Application​Entity​Title

AE

1


(0002,0017)

Sending Application Entity Title

Sending​Application​Entity​Title

AE

1


(0002,0018)

Receiving Application Entity Title

Receiving​Application​Entity​Title

AE

1


(0002,0026)

Source Presentation Address

Source​Presentation​Address

UR

1


(0002,0027)

Sending Presentation Address

Sending​Presentation​Address

UR

1


(0002,0028)

Receiving Presentation Address

Receiving​Presentation​Address

UR

1


(0002,0031)

RTV Meta Information Version

RTV​Meta​Information​Version

OB

1

(0002,0032)

RTV Communication SOP Class UID

RTV​Communication​SOP​Class​UID

UI

1

(0002,0033)

RTV Communication SOP Instance UID

RTV​Communication​SOP​Instance​UID

UI

1

(0002,0035)

RTV Source Identifier

RTV​Source​Identifier

OB

1

(0002,0036)

RTV Flow Identifier

RTV​Flow​Identifier

OB

1

(0002,0037)

RTV Flow RTP Sampling Rate

RTV​Flow​RTP​Sampling​Rate

UL

1

(0002,0038)

RTV Flow Actual Frame Duration

RTV​Flow​Actual​Frame​Duration

FD

1

(0002,0100)

Private Information Creator UID

Private​Information​Creator​UID

UI

1


(0002,0102)

Private Information

Private​Information

OB

1'
]

{ #category : #accessing }
DcFileMeta >> at:aKey [
^meta at: aKey
]

{ #category : #documentation }
DcFileMeta >> docs [
"https://dicom.nema.org/medical/dicom/current/output/chtml/part10/chapter_7.html"
"File Meta Information shall be encoded using the Explicit VR Little Endian Transfer Syntax (UID=1.2.840.10008.1.2.1) as defined in DICOM PS3.5. Values of each File Meta Element shall be padded when necessary to achieve an even length, as specified in PS3.5 by their corresponding Value Representation."
]

{ #category : #testing }
DcFileMeta >> isExplicitVR [

	| tsn uid |
	uid := (self at: 'TransferSyntaxUID') value.
	tsn := DcSyntax atUid: uid.
	^ tsn isExplicitVR
]

{ #category : #testing }
DcFileMeta >> isPrefixValid [

	^ self prefix asString = 'DICM'
]

{ #category : #accessing }
DcFileMeta >> preAmble [

	^ preAmble
]

{ #category : #accessing }
DcFileMeta >> prefix [

	^ prefix
]

{ #category : #reading }
DcFileMeta >> readMetaFrom: s [

	| infoGroupLength group attr reg key |
	preAmble := s next: 128. 
	prefix := (s next: 4) asString.
	infoGroupLength := (DcElement from: s explicitVR: true) value.
	group := s next: infoGroupLength.
	meta := Dictionary new.
	group readStreamDo: [ :gs | 
		[ gs atEnd ] whileFalse: [ 
			attr := DcElement from: gs explicitVR: true.
			reg := DcTable tagAt: attr tag.
			key := (reg at: 'Keyword') onlyLetters.
			meta at: key put: attr ] ]
]
