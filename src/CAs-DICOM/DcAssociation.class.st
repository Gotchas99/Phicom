Class {
	#name : #DcAssociation,
	#superclass : #Object,
	#instVars : [
		'ae',
		'aet',
		'ip',
		'port',
		'sck',
		'rq',
		'dimse'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcAssociation >> ae [

	^ ae
]

{ #category : #accessing }
DcAssociation >> ae: anObject [

	ae := anObject
]

{ #category : #accessing }
DcAssociation >> aet [

^	aet
]

{ #category : #accessing }
DcAssociation >> aet:anAET [
aet:=anAET
]

{ #category : #ssl }
DcAssociation >> connect [

	| buffstream tmp |
	sck := SocketStream openConnectionToHost: ip port: port timeout: 10.
	sck binary.
	buffstream := ZnBufferedWriteStream on: sck.
	rq writeOn: buffstream.
	buffstream flush.
	buffstream := ZnBufferedReadStream on: sck.
	tmp:= buffstream upToEnd.
	buffstream close.
self halt.
]

{ #category : #accessing }
DcAssociation >> dimse [

	^ dimse
]

{ #category : #accessing }
DcAssociation >> dimse: anObject [

	dimse := anObject
]

{ #category : #accessing }
DcAssociation >> ip: anIP [

	ip :=NetNameResolver
		           addressForName:  anIP
		           timeout: 10.
]

{ #category : #accessing }
DcAssociation >> port:aPort [
port:=aPort
]

{ #category : #ssl }
DcAssociation >> release [

	sck ifNotNil: [ sck close .sck:=nil]
]

{ #category : #ssl }
DcAssociation >> rq:anAssociateRq [
rq:=anAssociateRq
]
