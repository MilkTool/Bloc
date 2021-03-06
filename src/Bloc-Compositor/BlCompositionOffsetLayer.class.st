Class {
	#name : #BlCompositionOffsetLayer,
	#superclass : #BlCompositionWithOffsetLayer,
	#instVars : [
		'skiaLayer'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionOffsetLayer >> asSkiaLayer [
	<return: #SkiaCompositionOffsetLayer>

	(skiaLayer isNil or: [ self needsComposition ])
		ifTrue: [
			| theChildLayers |
			skiaLayer := self newSkiaLayer.
			theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
			theChildLayers do: [ :eachLayer | skiaLayer addLayer: eachLayer ] ]
		ifFalse: [ skiaLayer offset: self offset ].

	^ skiaLayer
]

{ #category : #drawing }
BlCompositionOffsetLayer >> drawOnSpartaCanvas: aCanvas [
	aCanvas transform
		by: [ :t | t translateBy: self offset ]
		during: [ super drawOnSpartaCanvas: aCanvas ]
]

{ #category : #accessing }
BlCompositionOffsetLayer >> name [
	^ 'Offset {1}' format: { self offset }
]

{ #category : #converting }
BlCompositionOffsetLayer >> newSkiaLayer [
	^ SkiaCompositionOffsetLayer offset: self offset
]
