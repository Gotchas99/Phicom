Class {
	#name : #DcTable,
	#superclass : #Object,
	#instVars : [
		'tblUid',
		'tagHex',
		'tagBin',
		'tagKeyword'
	],
	#classVars : [
		'TableCache',
		'TableIndex',
		'TagTable',
		'UidTable'
	],
	#category : #'CAs-DICOM-Util'
}

{ #category : #accessing }
DcTable class >> baseDir [

	^'c:\misc\dicomref'asFileReference 
]

{ #category : #samples }
DcTable class >> commandDictionaryText [

	^'Tag

Message Field

Keyword

VR

VM

Description of Field

(0000,0000)

Command Group Length

CommandGroupLength

UL

1

The even number of bytes from the end of the value field to the beginning of the next group.

(0000,0002)

Affected SOP Class UID

AffectedSOPClassUID

UI

1

The affected SOP Class UID associated with the operation.

(0000,0003)

Requested SOP Class UID

RequestedSOPClassUID

UI

1

The requested SOP Class UID associated with the operation.

(0000,0100)

Command Field

CommandField

US

1

This field distinguishes the DIMSE operation conveyed by this Message. This field shall be set to one of the following values:

0001H C-STORE-RQ

8001H C-STORE-RSP

0010H C-GET-RQ

8010H C-GET-RSP

0020H C-FIND-RQ

8020H C-FIND-RSP

0021HC-MOVE-RQ

8021H C-MOVE-RSP

0030H C-ECHO-RQ

8030H C-ECHO-RSP

0100H N-EVENT-REPORT-RQ

8100H N-EVENT-REPORT-RSP

0110H N-GET-RQ

8110H N-GET-RSP

0120H N-SET-RQ

8120H N-SET-RSP

0130H N-ACTION-RQ

8130H N-ACTION-RSP

0140H N-CREATE-RQ

8140H N-CREATE-RSP

0150H N-DELETE-RQ

8150H N-DELETE-RSP

0FFFH C-CANCEL-RQ

(0000,0110)

Message ID

MessageID

US

1

Implementation-specific value that distinguishes this Message from other Messages.

(0000,0120)

Message ID Being Responded To

MessageIDBeingRespondedTo

US

1

Shall be set to the value of the Message ID (0000,0110) field used in associated request Message.

(0000,0600)

Move Destination

MoveDestination

AE

1

Shall be set to the DICOM AE Title of the destination DICOM AE to which the C-STORE sub-operations are being performed.

(0000,0700)

Priority

Priority

US

1

The priority shall be set to one of the following values:

LOW = 0002H

MEDIUM = 0000H

HIGH = 0001H

(0000,0800)

Command Data Set Type

CommandDataSetType

US

1

This field indicates if a Data Set is present in the Message. This field shall be set to the value of 0101H if no Data Set is present; any other value indicates a Data Set is included in the Message.

(0000,0900)

Status

Status

US

1

Confirmation status of the operation. See Annex C.

(0000,0901)

Offending Element

OffendingElement

AT

1-n

If status is Cxxx, then this field contains a list of the elements in which the error was detected.

(0000,0902)

Error Comment

ErrorComment

LO

1

This field contains an application-specific text description of the error detected.

(0000,0903)

Error ID

ErrorID

US

1

This field shall optionally contain an application-specific error code.

(0000,1000)

Affected SOP Instance UID

AffectedSOPInstanceUID

UI

1

Contains the UID of the SOP Instance for which this operation occurred.

(0000,1001)

Requested SOP Instance UID

RequestedSOPInstanceUID

UI

1

Contains the UID of the SOP Instance for which this operation occurred.

(0000,1002)

Event Type ID

EventTypeID

US

1

Values for this field are application-specific.

(0000,1005)

Attribute Identifier List

AttributeIdentifierList

AT

1-n

This field contains an Attribute Tag for each of the n Attributes applicable.

(0000,1008)

Action Type ID

ActionTypeID

US

1

Values for this field are application-specific.

(0000,1020)

Number of Remaining Sub-operations

NumberOfRemainingSuboperations

US

1

The number of remaining C-STORE sub-operations to be invoked for the operation.

(0000,1021)

Number of Completed Sub-operations

NumberOfCompletedSuboperations

US

1

The number of C-STORE sub-operations associated with this operation that have completed successfully.

(0000,1022)

Number of Failed Sub-operations

NumberOfFailedSuboperations

US

1

The number of C-STORE sub-operations associated with this operation that have failed.

(0000,1023)

Number of Warning Sub-operations

NumberOfWarningSuboperations

US

1

The number of C-STORE sub-operations associated with this operation that generated warning responses.

(0000,1030)

Move Originator Application Entity Title

MoveOriginatorApplicationEntityTitle

AE

1

Contains the DICOM AE Title of the DICOM AE that invoked the C-MOVE operation from which this C-STORE sub-operation is being performed.

(0000,1031)

Move Originator Message ID

MoveOriginatorMessageID

US

1

Contains the Message ID (0000,0110) of the C-MOVE-RQ Message from which this C-STORE sub-operation is being performed.'
]

{ #category : #accessing }
DcTable class >> in: tblId atBin: bin [

	| tbl |
	tbl := TableIndex at: tblId ifAbsentPut: [ self new table_6_1 ].
	^tbl atBin: bin
]

{ #category : #'class initialization' }
DcTable class >> initialize [

	TagTable := nil.
	self initializeTableIndex.
	self initializeCache.
	self initializeTagTable.
	self initializeUidTable
]

{ #category : #'class initialization' }
DcTable class >> initializeCache [

	TableCache:=Dictionary new.
]

{ #category : #'class initialization' }
DcTable class >> initializeTableIndex [

	TableIndex := Dictionary new
]

{ #category : #'class initialization' }
DcTable class >> initializeTagTable [

	^ TagTable := self new
	part10;
		              part6;
		              part7
		              
]

{ #category : #'class initialization' }
DcTable class >> initializeUidTable [
<script>
	^ UidTable := self new part6_UID
]

{ #category : #'class initialization' }
DcTable class >> resetAll [
self allInstancesDo: [ :tbl|tbl initialize ]
]

{ #category : #samples }
DcTable class >> sample_10_11 [
^'Attribute Name

Tag

Type

Attribute Description

Referenced SOP Class UID

(0008,1150)

1

Uniquely identifies the referenced SOP Class.

Referenced SOP Instance UID

(0008,1155)

1

Uniquely identifies the referenced SOP Instance.'
]

{ #category : #accessing }
DcTable class >> tagAt: aTag [

	^ self tagTable tagAt: aTag
]

{ #category : #accessing }
DcTable class >> tagTable [

	^ TagTable ifNil: [ 
		  self initializeTagTable]
]

{ #category : #accessing }
DcTable class >> uidAtCode: aUidCode [

	^ UidTable uidAtCode: aUidCode
]

{ #category : #accessing }
DcTable class >> uidAtKeyword: aKeyword [

	^ UidTable uidAtKeyword: aKeyword
]

{ #category : #accessing }
DcTable >> atBin: aBinTag [

	^ tagBin at: aBinTag
]

{ #category : #accessing }
DcTable >> atHex: aHexTag [

	^tagHex at:aHexTag
]

{ #category : #accessing }
DcTable >> atHex: aHexTag fld: aFieldName [

	^( tagHex at: aHexTag)at:aFieldName
]

{ #category : #'as yet unclassified' }
DcTable >> file: aFilename cols: numCols headers: headers [

	| fs |
	fs := (self class baseDir / aFilename) readStream.
	self stream: fs cols: numCols headers: headers
	
]

{ #category : #initialization }
DcTable >> initialize [

	tagHex := Dictionary new.
	tagBin := Dictionary new.tagKeyword := Dictionary new.
	tblUid := Dictionary new
]

{ #category : #'as yet unclassified' }
DcTable >> oldReader [
"lines := aStream lines reject: [ :l | l isEmpty ].
	hdr := lines first: numCols.
	tblHex := Dictionary new.
	tblBin := Dictionary new.
	(lines allButFirst: numCols) readStreamDo: [ :s | 
		[ s atEnd ] whileFalse: [ 
			d := Dictionary new.
			(s next: numCols) with: hdr do: [ :val :h | d at: h put: val ].
			d at: 'Tag' ifPresent: [ :t | 
				tag := DcTag fromString: t.
				d at: #TagHex put: tag bin.
				tblHex at: (d at: 'Tag') put: d.
				tblBin at: tag bin put: d ] ] ]"
]

{ #category : #initialization }
DcTable >> part10 [

	| fname root url doc |
	fname := 'C:\Misc\dicomref\part10.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part10/part10.xml'.

	doc := fname asFileReference exists
		       ifTrue: [ XMLDOMParser parse: fname asFileReference ]
		       ifFalse: [ XMLDOMParser parseURL: url ].
	root := doc root.
	self table_7_1_1: root
]

{ #category : #initialization }
DcTable >> part6 [

	| fname root url doc |
	fname := 'C:\Misc\dicomref\part06.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part06/part06.xml'.

	doc := fname asFileReference exists
		       ifTrue: [ XMLDOMParser parse: fname asFileReference ]
		       ifFalse: [ XMLDOMParser parseURL: url ].
	root := doc root.
	self table_6_1: root.
		self table_8_1: root.

]

{ #category : #initialization }
DcTable >> part6_UID [

	| fname root url doc |
	fname := 'C:\Misc\dicomref\part06.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part06/part06.xml'.

	doc := fname asFileReference exists
		       ifTrue: [ XMLDOMParser parse: fname asFileReference ]
		       ifFalse: [ XMLDOMParser parseURL: url ].
	root := doc root.
	self table_A_1: root
]

{ #category : #initialization }
DcTable >> part7 [

	| fname root url doc |
	fname := 'C:\Misc\dicomref\part07.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part07/part07.xml'.

	doc := fname asFileReference exists
		       ifTrue: [ XMLDOMParser parse: fname asFileReference ]
		       ifFalse: [ XMLDOMParser parseURL: url ].
	root := doc root.
	self table_E_1_1: root
.		self table_E_2_1: root
]

{ #category : #helper }
DcTable >> readLine: aStream cols: numCols [

	| fld flds dummy |
	flds := OrderedCollection new.
	1 to: numCols do: [ :i | 
		fld := aStream nextLine.
		flds add: fld.
		fld isEmpty ifFalse: [ dummy:=  aStream nextLine ] ].
	^ flds
]

{ #category : #helper }
DcTable >> removeUnprintablesInKey: aKey from: aDict [

	| tmp |
	aDict at: aKey ifPresent: [ :val | 
		tmp := val select: [ :c | c shouldBePrintedAsLiteral ].
		aDict at: aKey put: tmp ]
]

{ #category : #helper }
DcTable >> saveRow: aDict [

	| tag |
	aDict at: 'Tag' ifPresent: [ :t | 
		(t beginsWith: '(') ifFalse: [ ^ self ].
		tag := DcTag fromString: t.
		aDict at: #TagHex put: tag bin.
		tagHex at: (aDict at: 'Tag') put: aDict.
		tagBin at: tag bin put: aDict.
		tagKeyword at: (aDict at: 'Keyword') put: aDict ]
]

{ #category : #'as yet unclassified' }
DcTable >> stream: aStream cols: numCols headers: headers [

	| line hdr d |
	[ tagHex := Dictionary new.
	tagBin := Dictionary new.
	hdr := self readLine: aStream cols: numCols.
	headers ifNotNil: [ hdr := headers ].
	[ aStream atEnd ] whileFalse: [ 
		d := Dictionary new.
		line := self readLine: aStream cols: numCols.
		line with: hdr do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ] ] ensure: [ aStream close ]
]

{ #category : #'as yet unclassified' }
DcTable >> table_6_1 [

	| fname root chapters chapter table thead hdrs tbody items d hdr61 url |
	self deprecated:'use the one with xml root param'.
	fname := 'C:\Misc\dicomref\part06.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part06/part06.xml'.

	root := (XMLDOMParser parseURL: url) root.
	"	root := (XMLDOMParser parse: fname asFileReference) root."
	chapters := root nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_6'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (chapter elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_6-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdr61 := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdr61 do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_6_1: anXmlRoot [

	| chapters chapter table thead hdrs tbody items d hdr61  |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_6'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (chapter elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_6-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdr61 := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdr61 do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_7_1_1: anXmlRoot [

	"In part 10 file info"

	| chapters chapter table thead hdrs tbody items d hdrFixed section |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_7'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	section := (chapter elementsAt: 'section') elementsDetect: [ :se | 
		           'sect_7.1'
		           = (se attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (section elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_7.1-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdrFixed := #( #Name #Tag #Type #Description ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdrFixed do: [ :val :h | d at: h put: val ].
		d at: 'Keyword' put: ((d at: 'Name') copyReplaceAll: ' ' with: '').
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_8_1: anXmlRoot [

	"In part 10 file info"

	| chapters chapter table thead hdrs tbody items d hdrFixed |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_8'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (chapter elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_8-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdrFixed := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdrFixed do: [ :val :h | d at: h put: val ].
		d at: 'Keyword' put: ((d at: 'Name') copyReplaceAll: ' ' with: '').
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_A_1: anXmlRoot [

	| chapters chapter table thead hdrs tbody items d hdr61 |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_A'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (chapter elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_A-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdr61 := #( #UID #Name #Keyword #Type #Part ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdr61 do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		tblUid at: (d at:#UID) put:(d at:#Keyword) ]
]

{ #category : #'as yet unclassified' }
DcTable >> table_E_1_1 [

	| fname root chapters chapter table thead hdrs tbody items d hdre11 url section |	self deprecated:'use the one with xml root param'.
	fname := 'C:\Misc\dicomref\part07.xml'.
	url := 'https://dicom.nema.org/medical/dicom/current/source/docbook/part07/part07.xml'.

	root := (XMLDOMParser parseURL: url) root.
	"	root := (XMLDOMParser parse: fname asFileReference) root."
	chapters := root nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_E'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	section := (chapter elementsAt: 'section') elementsDetect: [ :se | 
		           'sect_E.1'
		           = (se attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (section elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_E.1-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdre11 := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdrs do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_E_1_1: anXmlRoot [

	|   chapters chapter table thead hdrs tbody items d hdre11  section |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_E'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	section := (chapter elementsAt: 'section') elementsDetect: [ :se | 
		           'sect_E.1'
		           = (se attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (section elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_E.1-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdre11 := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdrs do: [ :val :h | d at: h put: val ].
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #initialization }
DcTable >> table_E_2_1: anXmlRoot [
"Retired commands"
	| chapters chapter table thead hdrs tbody items d hdre11 section |
	chapters := anXmlRoot nodes elementsAt: 'chapter'.
	chapter := chapters elementsDetect: [ :ch | 
		           'chapter_E'
		           = (ch attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	section := (chapter elementsAt: 'section') elementsDetect: [ :se | 
		           'sect_E.2'
		           = (se attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	table := (section elementsAt: 'table') elementsDetect: [ :tab | 
		         'table_E.2-1'
		         = (tab attributeAt: 'xml:id' ifAbsent: [ '***' ]) ].
	thead := (table elementsAt: 'thead') first elements first.
	hdrs := thead elements collect: [ :th | th contentString trim ].
	hdre11 := #( #Tag #Name #Keyword #VR #VM #Comment ).
	tbody := (table elementsAt: 'tbody') first elements.
	items := tbody collect: [ :tr | 
		         tr elements collect: [ :td | 
			         td contentString trim select: [ :c | c isOctetCharacter ] ] ].
	items do: [ :line | 
		d := Dictionary new.
		line with: hdrs do: [ :val :h | d at: h put: val ].
		d at:#Comment put:'Retired command'.
		self removeUnprintablesInKey: 'Keyword' from: d.
		self saveRow: d ]
]

{ #category : #accessing }
DcTable >> tagAt: aTag [

	| tmp |
	aTag isNumber ifTrue: [ tmp := tagBin at: aTag ].
	aTag isString ifTrue: [ tmp :=
		(aTag beginsWith: '(')
			ifTrue: [  tagHex at: aTag ]
			ifFalse: [  tagKeyword at: aTag ] ].
	aTag class = DcTag ifTrue: [ tmp := tagBin at: aTag bin ].
	tmp ifNil: [ Error signal: 'unknown tag' ].
	^ tmp
]

{ #category : #'as yet unclassified' }
DcTable >> text: aString cols: numCols [
self text: aString cols: numCols headers: nil
]

{ #category : #'as yet unclassified' }
DcTable >> text: aString cols: numCols headers: headers [

	"| lines hdr d tag |"
	self stream: aString readStream cols: numCols headers: headers
	"lines := aString lines reject: [ :l | l isEmpty ].
	hdr := lines first: numCols.
	tblHex := Dictionary new.
	tblBin := Dictionary new.
	(lines allButFirst: numCols) readStreamDo: [ :s | 
		[ s atEnd ] whileFalse: [ 
			d := Dictionary new.
			(s next: numCols) with: hdr do: [ :val :h | d at: h put: val ].
			d at: 'Tag' ifPresent: [ :t | 
				tag := DcTag fromString: t.
				d at: #TagHex put: tag bin.
				tblHex at: (d at: 'Tag') put: d.
				tblBin at: tag bin put: d ] ] ]"
]

{ #category : #accessing }
DcTable >> uidAtCode: aUidCode [

	^ tblUid at: aUidCode ifAbsent:[aUidCode ]
]

{ #category : #accessing }
DcTable >> uidAtKeyword: aKeyword [

	^ tblUid  keyAtValue:  aKeyword
]
