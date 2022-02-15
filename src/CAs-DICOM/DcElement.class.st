"
A Data Element is uniquely identified by a Data Element Tag

The encoding of the Command Set shall be Little Endian Byte Ordering as defined in PS3.5

The encoding (of the command set) corresponds to the Implicit VR Data Element encoding defined in PS3.5

A Data Element shall have one of three structures. Two of these structures contain the VR of the Data Element (Explicit VR) but differ in the way their lengths are expressed, while the other structure does not contain the VR (Implicit VR). All three structures contain the Data Element Tag, Value Length and Value for the Data Element. See Figure 7.1-1.

Data Element Tag
An ordered pair of 16-bit unsigned integers representing the Group Number followed by Element Number.

Value Representation
Two single byte characters containing the VR of the Data Element. The VR for a given Data Element Tag shall be as defined by the Data Dictionary as specified in PS3.6. The two byte VR shall be encoded using only upper case letters from the DICOM default character set

Value Length
Either:

a 16 or 32-bit (dependent on VR and whether VR is explicit or implicit) unsigned integer containing the Explicit Length of the Value Field as the number of bytes (even) that make up the Value. It does not include the length of the Data Element Tag, Value Representation, and Value Length Fields.

a 32-bit Length Field set to Undefined Length (FFFFFFFFH). Undefined Lengths may be used for Data Elements having the Value Representation (VR) Sequence of Items (SQ) and Unknown (UN). For Data Elements with Value Representation OW or OB Undefined Length may be used depending on the negotiated Transfer Syntax (see Section 10 and Annex A).

Value Field
An even number of bytes containing the Value(s) of the Data Element.
"
Class {
	#name : #DcElement,
	#superclass : #Object,
	#instVars : [
		'tag',
		'length',
		'vr',
		'explicitVR',
		'rawValue',
		'value'
	],
	#classVars : [
		'RawCodes',
		'VRvalueCode'
	],
	#category : #'CAs-DICOM-Core'
}

{ #category : #accessing }
DcElement class >> RawCodes [

	^ RawCodes
]

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
DcElement class >> from: s explicitVR: aBoolean [
	^ self new from: s explicitVR: aBoolean
]

{ #category : #initialization }
DcElement class >> initialize [

	self initializeVRvalues.
self 	initializeRawValues
]

{ #category : #initialization }
DcElement class >> initializeRawValues [

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
	SQ=Sequence
	TM=Time
	UI=UID
	UL=Unsigned Long
	US=Unsigned Short"

	"DA and TM need to be converted from real date and time	"

	RawCodes := Dictionary new.
	RawCodes
		at: 'DA' put: [ :val | val asString trimmed ];
		at: 'DS' put: [ :val | val printString asByteArray ];
		at: 'SQ' put: [ :val | 
			self halt.
			val asString trimmed ];
		at: 'TM' put: [ :val | val asString trimmed ];
		at: 'UI' put: [ :val | val padToEvenNull asByteArray ];
		at: 'UL' put: [ :val | 
			(ByteArray new: 4)
				unsignedLongAt: 1 put: val bigEndian: false;
				yourself ];
		at: 'US' put: [ :val | "unsignedLongAt: 1 bigEndian: true."
		(ByteArray new: 2)
			unsignedShortAt: 1 put: val bigEndian: false;
			yourself ]
]

{ #category : #initialization }
DcElement class >> initializeVRvalues [

	"As=Age (string ending with e.g. 'Y')
	CS=Code String
	DA=Date
	DS=Decimal String
	IS=Integer String
	LO=Long string
	OB=Other byte
	OW=Other Word
	PN=Person Name
	SH=Short String
	SQ=Sequence
	TM=Time
	UI=UID
	UL=Unsigned Long
	US=Unsigned Short"

	VRvalueCode := Dictionary new.
	VRvalueCode
		at: 'AS' put: #asString;
		at: 'CS' put: #asString;
		"needs to be converted to real date
		"at: 'DA' put: #asString;
		at: 'DS' put: #asNumber;
		at: 'IS' put: #asNumber;
		at: 'LO' put: #asString;
		at: 'OB' put: #asRaw;
		at: 'OW' put: #asRaw;
		at: 'PN' put: #asString;
		at: 'SH' put: #asString;
		at: 'SQ' put: #asSeq;
		"needs to be converted to real time
		"at: 'TM' put: #asString;
		at: 'UI' put: #asUID;
		at: 'UL' put: #asLong;
		at: 'US' put: #asShort
]

{ #category : #comparing }
DcElement >> <= otherElement [

	^ tag <= otherElement tag
]

{ #category : #converting }
DcElement >> asLong [

	^ rawValue longAt: 1 bigEndian: false
]

{ #category : #converting }
DcElement >> asNumber [

	^ rawValue asString trimmed asNumber 
]

{ #category : #converting }
DcElement >> asRaw [

	^ rawValue 
]

{ #category : #converting }
DcElement >> asSeq [

	| items it |
	items := OrderedCollection new.
	rawValue readStreamDo: [ :s | 
		[ s atEnd ] whileFalse: [ 
			it := DcSqItem from: s explicitVR: explicitVR .
			items add: it ] ].
	^ items
]

{ #category : #converting }
DcElement >> asShort [

	^ rawValue  shortAt: 1
		                   bigEndian: false.
]

{ #category : #converting }
DcElement >> asString [

	^ rawValue asString trimmed
]

{ #category : #converting }
DcElement >> asUID [

	^ (rawValue reject: [ :b | b = 0 ]) asString trimmed

]

{ #category : #accessing }
DcElement >> assoc [
^tag keyword -> self value.

	
]

{ #category : #validating }
DcElement >> checkLength [

	| buffstream b |
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     self writeOn: buffstream.
		     buffstream close ].

	b size = self groupLength ifFalse: [ self halt ].
	self traceCr: self class name , ' ' , 'checkLength passed'
]

{ #category : #accessing }
DcElement >> explicitVR: aBoolean [

 explicitVR :=	self isCommandElement
		ifTrue: [ false ]
		ifFalse: [  aBoolean ]
]

{ #category : #'instance creation' }
DcElement >> from: s explicitVR: aBoolean [

	tag := DcTag from: s.
	self explicitVR: aBoolean.
	explicitVR
		ifTrue: [ self getVR: s ]
		ifFalse: [ vr := tag vr ].
	self getLength: s.
	self getValue: s
]

{ #category : #'instance creation' }
DcElement >> getLength: s [

	"Undefined Length = FFFFFFFFH"

	length := s nextLittleEndianNumber: self lengthLength .
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

	rawValue := s next: length.value:=nil.
]

{ #category : #accessing }
DcElement >> groupLength [

	| len |
	len := 4. "tag"
	len := len + self lengthLength.
	self isExplicitVR ifTrue: [ len := len + self lengthLength ].
	len := len + self rawValue size.
	^ len
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

	^ self shortVRs includes: self vr
]

{ #category : #testing }
DcElement >> isUndefined [

	"Undefined Length = FFFFFFFFH"

	^ length = 4294967295.
]

{ #category : #accessing }
DcElement >> keyword [ ^tag keyword 
]

{ #category : #'instance creation' }
DcElement >> keyword: aKeyword value: aValue [

	tag := DcTag fromKeyword: aKeyword.
	self value: aValue
]

{ #category : #helper }
DcElement >> lengthLength [

	"different size of length field"

	| size |
	size := explicitVR
		        ifTrue: [ 
			        self isShortVR
				        ifTrue: [ 2 ]
				        ifFalse: [ 4 ] ]
		        ifFalse: [ 4 ].
	^ size
]

{ #category : #printing }
DcElement >> printOn: aStream [

	super printOn: aStream.
	aStream << $( << tag keyword << 
	'('<< self vr<<')'<<
	': '.
	self vr = 'UI'
		ifTrue: [ aStream << (DcTable uidAtCode: self value) ]
		ifFalse: [ self value printOn: aStream ].
	aStream << $)
]

{ #category : #accessing }
DcElement >> rawValue [

	^ rawValue ifNil: [ 
		  rawValue := (self class RawCodes
			               at: self vr
			               ifAbsent: [ [ :v | v padToEven asByteArray ] ]) value: value ]
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

	^ value ifNil: [ 
		  value :=self perform: (self class VRcodes at: self vr)  ]
]

{ #category : #accessing }
DcElement >> value: aValue [

	value:=aValue .rawValue :=nil
]

{ #category : #accessing }
DcElement >> vr [

	^ vr ifNil: [ vr:= tag vr ]
]

{ #category : #writing }
DcElement >> writeLength: s [

	"Undefined Length = FFFFFFFFH"
 s
		          nextLittleEndianNumber: self lengthLength
		          put: self rawValue size
]

{ #category : #writing }
DcElement >> writeOn: s [

	tag writeOn: s.
	explicitVR ifTrue: [ self writeVR: s ].
	self writeLength: s.
	self writeValue: s
]

{ #category : #writing }
DcElement >> writeVR: s [

self 	vr putOn: s.
	self isShortVR ifTrue: [ s nextPutAll: #( 0 0 ) ]
]

{ #category : #writing }
DcElement >> writeValue: s [

	self rawValue putOn:s.
]
