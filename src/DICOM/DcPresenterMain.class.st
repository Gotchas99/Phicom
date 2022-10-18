Class {
	#name : #DcPresenterMain,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'files',
		'flds',
		'currentMedia',
		'ds',
		'els'
	],
	#category : #'DICOM-Ui'
}

{ #category : #initialization }
DcPresenterMain class >> defaultSpec [

	| topRow |
	topRow := SpBoxLayout newLeftToRight
		          add: #files;
		          add: #els expand: true.
	^ SpBoxLayout newTopToBottom
		  add: topRow height: 165;
		  add: #flds expand: true;
		  yourself
]

{ #category : #initialization }
DcPresenterMain >> connectPresenters [

	| sel fname |
	files whenSelectionChangedDo: [ :selection | 
		[ :elem |  
		sel := elem first.
		fname := elem third ] cull: selection selectedItem.
		currentMedia := DcObjectFile new filename: fname.
		ds := currentMedia read dataset.
		els items: ds elements ].
	els whenSelectionChangedDo: [ :selection | 
		[ :elem | elem ifNotNil: [ flds items: elem parse ] ] cull:
			selection selectedItem ]
]

{ #category : #initialization }
DcPresenterMain >> initialExtent [

	^ 800 @ 800
]

{ #category : #initialization }
DcPresenterMain >> initializePresenters [

	files := self newTable.
	files
		beResizable;
		addColumn:
			((SpStringTableColumn title: 'Selector' evaluated: #first) width:
					 25);
		addColumn:
			(SpStringTableColumn title: 'Description' evaluated: #second);
		items: self sampleMessages.
	els := self newList  display: [ :el | el printString ].
	flds := SpTablePresenter new
		        addColumn:
			        ((SpStringTableColumn title: 'Index' evaluated: #first) 
				         width: 15);
		        addColumn:
			        (SpStringTableColumn title: 'Field' evaluated: #second);
		        addColumn:
			        (SpStringTableColumn title: 'Value' evaluated: #last);
		        yourself
]

{ #category : #initialization }
DcPresenterMain >> initializeWindow: aWindowPresenter [
aWindowPresenter
	title: self title;
		initialExtent: self initialExtent
]

{ #category : #api }
DcPresenterMain >> sampleMessages [

	^ #( #( #sample1 'Felix' 'C:\MiscTools\Dicoogle_v3.0.2\storage\FELIX\IM-0001-0075.dcm4763272c-307c-4f43-9fcf-b819bf13eef8.dcm' )
	     #( #adtA08 'CT image' 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\Stråldosregister\Exempel dicom2\DICOM\00002ECF\AA50A585\AA1A94E5\00000F02\EE5304EE' )
	     #( #adtA08_2 'RDSR' 'C:\Users\chras8\OneDrive - Västra Götalandsregionen\Stråldosregister\Exempel dicom2\DICOM\00002ECF\AA50A585\AA1A94E5\00000448\FF8829E7' ) )


]

{ #category : #initialization }
DcPresenterMain >> title [

	^ 'DICOM - app'
]
