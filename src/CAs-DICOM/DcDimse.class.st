Class {
	#name : #DcDimse,
	#superclass : #Object,
	#instVars : [
		'ae'
	],
	#classVars : [
		'CmdCode'
	],
	#category : #'CAs-DICOM-Dimse'
}

{ #category : #'class initialization' }
DcDimse class >> cmdCodeText [

	^ '0001H C-STORE-RQ

8001H C-STORE-RSP

0010H C-GET-RQ

8010H C-GET-RSP

0020H C-FIND-RQ

8020H C-FIND-RSP

0021H C-MOVE-RQ

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

0FFFH C-CANCEL-RQ'
]

{ #category : #'class initialization' }
DcDimse class >> initialize [

self initializeCmdCode
]

{ #category : #'class initialization' }
DcDimse class >> initializeCmdCode [

	| lines f code |
	CmdCode := Dictionary new.
	lines := self cmdCodeText lines reject: [ :aLine | aLine isEmpty ].
	lines do: [ :aLine | 
		f := ' ' split: aLine.
		code := self parseHex: f first .
		CmdCode at:code put:f second].^CmdCode
]

{ #category : #parsing }
DcDimse class >> parseHex: aHexString [

	^ (aHexString copyWithoutAll: 'H')
		  inject: 0
		  into: [ :sum :each | sum * 16 + each hexDigitValue ]
]

{ #category : #accessing }
DcDimse >> ae: anAE [

	| dul |
	ae := anAE.
	dul := DcUpperLayerServer default.
	dul registerDimse: self for: ae aeTitle
]

{ #category : #'as yet unclassified' }
DcDimse >> cEcho:param [
]

{ #category : #'as yet unclassified' }
DcDimse >> indicationService: service param: param forAssoc: anAssoc [

	| resp |
	self traceCr: 'DIMSE.indication recieved.service: ' , service.

	#pData = service ifTrue: [ 
				self pData: param forAssoc: anAssoc .resp := nil.].

	^ resp
]

{ #category : #'as yet unclassified' }
DcDimse >> pData: pdvList forAssoc: anAssoc [

	| element fs ctx req |
	self flag: 'hur hittar man exp/imp VR'.
	pdvList do: [ :pdv | 
		ctx := anAssoc presCtxAt: pdv presCtxId.
		fs := pdv fragment readStream.
		[ fs atEnd ] whileFalse: [ 
			element := DcElement from: fs explicitVR: false.
			anAssoc addIncomingElement: element ].
		"anAssoc addFragment: pdv fragment isCmd: pdv isCommand."
		pdv isLast ifTrue: [ 
			req := anAssoc lastElement. "lastFragment"
			req ifNotNil: [ anAssoc ae indication:req cmd with: req for: anAssoc  ] ] ]
]
