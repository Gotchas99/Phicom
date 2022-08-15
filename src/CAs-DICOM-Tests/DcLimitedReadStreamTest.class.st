"
A DcLimitedReadStreamTest is a test class for testing the behavior of DcLimitedReadStream
"
Class {
	#name : #DcLimitedReadStreamTest,
	#superclass : #TestCase,
	#category : #'CAs-DICOM-Tests-Util'
}

{ #category : #tests }
DcLimitedReadStreamTest >> testAtEnd1 [

	| str s1 t1 |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	str next: 5.
	s1 := DcLimitedReadStream on: str length: 5.
	t1 := s1 next: 5.
	self assert: s1 atEnd 
]

{ #category : #tests }
DcLimitedReadStreamTest >> testAtEnd2 [

	| str s1 t1 |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	str next: 5.
	s1 := DcLimitedReadStream on: str length: 5.
	t1 := s1 next: 3.
	self deny: s1 atEnd 
]

{ #category : #tests }
DcLimitedReadStreamTest >> testAtEnd3 [

	| str s1 |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	str next: 25.
	s1 := DcLimitedReadStream on: str length: 5.
	self should: [ s1 next: 3 ] raise: SubscriptOutOfBounds
]

{ #category : #tests }
DcLimitedReadStreamTest >> testBasic1 [

	| str s1 |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	s1 := DcLimitedReadStream on: str length: 5.
	self assert: s1 next equals: $A
]

{ #category : #tests }
DcLimitedReadStreamTest >> testBasic2 [

	| str s1 |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	str next:5.
	s1 := DcLimitedReadStream on: str length: 5.
	self assert: s1 next equals: $F
]

{ #category : #tests }
DcLimitedReadStreamTest >> testBasic3 [

	| str s1  |
	str := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' readStream.
	str next: 5.
	s1 := DcLimitedReadStream on: str length: 5.
	self should: [ s1 next: 6 ] raise: SubscriptOutOfBounds
]
