Class {
	#name : #BlLayoutExactResizer,
	#superclass : #BlLayoutResizer,
	#instVars : [
		'size'
	],
	#classInstVars : [
		'zero',
		'fifty',
		'hundred'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutExactResizer class >> cleanUp [
	super cleanUp.
	
	zero := nil.
	fifty := nil.
	hundred := nil
]

{ #category : #accessing }
BlLayoutExactResizer class >> fifty [
	^ fifty ifNil: [ fifty := self new size: 50 ]
]

{ #category : #accessing }
BlLayoutExactResizer class >> hundred [
	^ hundred ifNil: [ hundred := self new size: 100 ]
]

{ #category : #accessing }
BlLayoutExactResizer class >> size: aNumber [
	aNumber isZero
		ifTrue: [ ^ self zero ].
		
	aNumber = 50
		ifTrue: [ ^ self fifty ].
		
	aNumber = 100
		ifTrue: [ ^ self hundred ].

	^ self new
		size: aNumber;
		yourself 
]

{ #category : #accessing }
BlLayoutExactResizer class >> zero [
	^ zero ifNil: [ zero := self new size: 0 ]
]

{ #category : #comparing }
BlLayoutExactResizer >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self size = anObject size
]

{ #category : #comparing }
BlLayoutExactResizer >> hash [
	^ super hash bitXor: self size hash
]

{ #category : #controlling }
BlLayoutExactResizer >> ifExact: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutExactResizer >> isExact [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementAtMostWith: aNumber [
	^ BlMeasurementSpec exact: self size
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementExactlyWith: aNumber [
	^ BlMeasurementSpec exact: self size
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementUnspecifiedWith: aNumber [
	^ BlMeasurementSpec exact: self size
]

{ #category : #printing }
BlLayoutExactResizer >> printOn: aStream [
	aStream
		nextPutAll: 'Exact ';
		nextPutAll: self size asString
]

{ #category : #accessing }
BlLayoutExactResizer >> size [
	^ size
]

{ #category : #accessing }
BlLayoutExactResizer >> size: aNumber [
	self
		assert: [ size isNil ]
		description: [ 'Size can not be changed once set (immutability)' ].
		
	size := aNumber
]