"
A DcElementTest is a test class for testing the behavior of DcElement
"
Class {
	#name : #DcElementTest,
	#superclass : #TestCase,
	#category : #'DICOM-Tests-Core'
}

{ #category : #tests }
DcElementTest >> test1 [

	"fragment. list of elements. consume until end"

	| bytes |
	bytes := #( 0 0 0 0 4 0 0 0 56 0 0 0 0
	
	 0 2 0 18 0 0 0 49 46 50 46 56
	            52 48 46 49 48 48 48 56 46 49 46 49 0 0 0 0 1 2 0 0 0 48
	            0 0 0 16 1 2 0 0 0 2 0 0 0 0 8 2 0 0 0 1 1 )
]
