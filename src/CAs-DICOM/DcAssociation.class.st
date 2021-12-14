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
		'dimse',
		'currentMsg'
	],
	#category : #'CAs-DICOM-AE'
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
DcAssociation >> currentMsg [
^currentMsg ifNil:[currentMsg:= DcMessage new.]
	
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
