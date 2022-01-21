"
The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5.
"
Class {
	#name : #DcElement,
	#superclass : #Object,
	#instVars : [
		'tag',
		'length',
		'vr',
		'value',
		'explicitVR'
	],
	#classVars : [
		'VRvalueCode'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #accessing }
DcElement class >> VRcodes [

	^ VRvalueCode
	
]

{ #category : #documentation }
DcElement class >> docs_VR [

	"https://dicom.nema.org/medical/dicom/current/output/chtml/part05/sect_6.2.html"

	"CS

Code String

A string of characters identifying a controlled concept. Leading or trailing spaces (20H) are not significant."
"LO

Long String

A character string that may be padded with leading and/or trailing spaces. The character code 5CH (the BACKSLASH ""\"" in ISO-IR 6) shall not be present, as it is used as the delimiter between values in multi-valued data elements. The string shall not have Control Characters except for ESC."
	"OB

Other Byte

An octet-stream where the encoding of the contents is specified by the negotiated Transfer Syntax. OB is a VR that is insensitive to byte ordering (see Section 7.3). The octet-stream shall be padded with a single trailing NULL byte value (00H) when necessary to achieve even length."

	"UI

Unique Identifier (UID)

A character string containing a UID that is used to uniquely identify a wide variety of items. The UID is a series of numeric components separated by the period ""."" character. If a Value Field containing one or more UIDs is an odd number of bytes in length, the Value Field shall be padded with a single trailing NULL (00H) character to ensure that the Value Field is an even number of bytes in length. See Section 9 and Annex B for a complete specification and examples."

	"UL

Unsigned Long

Unsigned binary integer 32 bits long. Represents an integer n in the range:

0 <= n < 232."

	
]

{ #category : #'instance creation' }
DcElement class >> from:s [
^self new from:s
]

{ #category : #'instance creation' }
DcElement class >> from: s explicitVR: aBoolean [
	^ self new from: s explicitVR: aBoolean
]

{ #category : #initialization }
DcElement class >> initialize [

self 	initializeVRvalues
]

{ #category : #initialization }
DcElement class >> initializeVRvalues [

	"As=Age (string ending with e.g. 'Y')
	CS=Code String
	DA=Date
	DS=Decimal String
	IS=not sure. dimensions for image?
	LO=Long string
	OB=Other byte
	OW=Other Word
	PN=Person Name
	SH=Short String
	TM=Time
	UI=UID
	UL=Unsigned Long
	US=Unsigned Short"

	VRvalueCode := Dictionary new.
	VRvalueCode
		at: 'AS' put: [ :raw | raw asString trimmed ];
		at: 'CS' put: [ :raw | raw asString trimmed ];
		"needs to be converted to real date
		"at: 'DA'
		put: [ :raw | raw asString trimmed ];
		at: 'DS' put: [ :raw | raw asString trimmed asNumber ];
		at: 'IS'
		put: [ :raw | raw asString trimmed ];
	at: 'LO' put: [ :raw | raw asString trimmed ];
		at: 'OB' put: [ :raw | raw ];
		at: 'OW' put: [ :raw | raw ];
		at: 'PN' put: [ :raw | raw asString trimmed ];
		at: 'SH' put: [ :raw | raw asString trimmed ];
		"needs to be converted to real time
		"at: 'TM'
		put: [ :raw | raw asString trimmed ];
		at: 'UI'
		put: [ :raw | (raw reject: [ :b | b = 0 ]) asString trimmed ];
		at: 'UL' put: [ :raw | raw unsignedLongAt: 1 bigEndian: false ];
		at: 'US' put: [ :raw | raw unsignedShortAt: 1 bigEndian: false ]
]

{ #category : #comparing }
DcElement >> <= otherElement [

	^ tag <= otherElement tag
]

{ #category : #accessing }
DcElement >> asLong [

	^ value longAt: 1 bigEndian: false
]

{ #category : #accessing }
DcElement >> asShort [

	^ value  shortAt: 1
		                   bigEndian: false.
]

{ #category : #accessing }
DcElement >> assoc [
^tag keyword -> self value.

	
]

{ #category : #'instance creation' }
DcElement >> from: s [

self 	from: s explicitVR: false
]

{ #category : #'instance creation' }
DcElement >> from: s explicitVR: aBoolean [

	explicitVR := aBoolean.
	tag := DcTag from: s.
	explicitVR ifTrue: [ self getVR: s ]ifFalse:[vr:=tag vr.].
	self getLength: s.
	self getValue: s
]

{ #category : #'instance creation' }
DcElement >> getLength: s [

	"Undefined Length = FFFFFFFFH"

	length := explicitVR
		          ifTrue: [ 
			          self isShortVR
				          ifTrue: [ s nextLittleEndianNumber: 2 ]
				          ifFalse: [ s nextLittleEndianNumber: 4 ] ]
		          ifFalse: [ s nextLittleEndianNumber: 4 ]
]

{ #category : #'instance creation' }
DcElement >> getVR: s [

	vr := (s next: 2) asString.
	self isShortVR ifFalse: [ s skip: 2 ].
	^ vr
]

{ #category : #'instance creation' }
DcElement >> getValue: s [

	"Undefined Length = FFFFFFFFH"

	value := s next:length
]

{ #category : #initialization }
DcElement >> initialize [ 
explicitVR :=false
]

{ #category : #testing }
DcElement >> isCommandElement [

	^ tag isCommand
]

{ #category : #testing }
DcElement >> isExplicitVR [

	^ explicitVR
]

{ #category : #testing }
DcElement >> isShortVR [

	^self shortVRs includes:vr

]

{ #category : #testing }
DcElement >> isUndefined [

	"Undefined Length = FFFFFFFFH"

	^ length = 4294967295.
]

{ #category : #accessing }
DcElement >> keyword [ ^tag keyword 
]

{ #category : #accessing }
DcElement >> keyword:aKeyword value:aValue [

	tag:= DcTag fromKeyword: aKeyword
]

{ #category : #printing }
DcElement >> printOn: aStream [

	super printOn: aStream.

	aStream << $(.
	tag keyword  printOn: aStream.
	aStream << ': '.
	self value printOn: aStream.
	aStream << $)
]

{ #category : #accessing }
DcElement >> rawValue [

	^ value
]

{ #category : #accessing }
DcElement >> shortVRs [

	

	^ #( #AE , #AS , #AT , #CS , #DA , #DS , #DT , #FL , #FD , #IS , #LO
	     , #LT , #PN , 3 SH , #SL , #SS , #ST , #TM , #UI , #UL , #US )
]

{ #category : #accessing }
DcElement >> tag [
 ^tag
]

{ #category : #accessing }
DcElement >> value [

	^ (self class VRcodes at: vr)value:value
]

{ #category : #accessing }
DcElement >> vr [
^vr
]
