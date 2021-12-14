Class {
	#name : #DcItemComplex,
	#superclass : #DcItem,
	#category : #'CAs-DICOM-Net'
}

{ #category : #accessing }
DcItemComplex >> addItem:anItem [
items add:anItem
]

{ #category : #'instance creation' }
DcItemComplex >> readItemFrom: stream [
self readMyFieldsFrom:stream.
	self readSubItemsFrom: stream
]

{ #category : #'instance creation' }
DcItemComplex >> readMyFieldsFrom: stream [
]

{ #category : #'instance creation' }
DcItemComplex >> readSubItemsFrom: stream [

	| it |
	[ stream atEnd ] whileFalse: [ 
		it := DcItem readFrom: stream.
		items add: it ]
]

{ #category : #writing }
DcItemComplex >> writeMyFieldsOn: stream [

	

]

{ #category : #writing }
DcItemComplex >> writeOn: stream [

	super writeOn: stream.
	self writeMyFieldsOn: stream.
	self writeSubItemsOn: stream.
	
]

{ #category : #writing }
DcItemComplex >> writeSubItemsOn: stream [

	items do: [ :item | item writeOn: stream ]
]
