Extension { #name : #BlCompositionLayer }

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtPreviewFor: aView [
	<gtView>
	
	^ aView sparta
		title: 'Preview';
		priority: 3;
		matchParent;
		rendering: [ :aCanvas |
			| aSkiaLayer |
			aSkiaLayer := self asSkiaLayer.
			SkiaCompositor newDuring: [ :aCompositor | aCompositor draw: aSkiaLayer on: aCanvas ] ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> gtTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Tree';
		priority: 2;
		painting: [ :aMondrian | self paintTreeWith: aMondrian ]
]

{ #category : #'*Bloc-Compositor-GToolkit' }
BlCompositionLayer >> paintTreeWith: view [
	view nodes
		shape: [ :each |
			BlElement new
				layout: (BlLinearLayout vertical alignCenter);
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				background: Color white;
				when: BlClickEvent do: [ :anEvent | anEvent currentTarget phlow spawnObject: each ];
				padding: (BlInsets all: 10);
				zIndex: 10;
				addChild: (BlTextElement new
					padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
					border: (((each isKindOf: BlCompositionPictureLayer) and: [ each isWorthCaching ])
						ifTrue: [ BlBorder paint: Color red width: 1 ]
						ifFalse: [ BlBorder paint: Color gray width: 1 ]);
					text: each name asRopedText glamorousRegularFontAndSize);
				in: [ :aNodeElement |
					(each isKindOf: BlCompositionPictureLayer)
						ifTrue: [ aNodeElement addChild: (each asForm asElement asScalableElement
							fitWidth;
							background: Color white;
							margin: (BlInsets top: 10);
							look: BrShadowLook new;
							constraintsDo: [ :c |
								c horizontal exact: 100.
								c vertical fitContent ]
						) ]
				];
				yourself ];
		with: (self withDeepCollect: #children).
	view edges
		fromNearestBounds;
		toNearestBounds;
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		nodeDistance: 10;
		levelDistance: 20
]
