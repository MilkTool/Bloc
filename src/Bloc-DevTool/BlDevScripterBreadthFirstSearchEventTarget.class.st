Class {
	#name : #BlDevScripterBreadthFirstSearchEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#instVars : [
		'target'
	],
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #searching }
BlDevScripterBreadthFirstSearchEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	anElement allChildrenBreadthFirstDo: [ :eachChild |
		| aResult |
		[ aResult := self target findTargetIn: eachChild ] 
			on: Error
			do: [ :anException | aResult := nil ].
		aResult ifNotNil: [ ^ aResult ] ].
	self error: 'Cannot find target at ', self target printString.
]

{ #category : #accessing }
BlDevScripterBreadthFirstSearchEventTarget >> target [
	<return: #BlDevScripterEventTarget>
	^ target
]

{ #category : #accessing }
BlDevScripterBreadthFirstSearchEventTarget >> target: aBlDevScripterEventTarget [
	self
		assert: [ aBlDevScripterEventTarget isNotNil ]
		description: [ 'Scripter event target must be non-nil' ].
	self
		assert: [ (aBlDevScripterEventTarget isKindOf: BlDevScripterBreadthFirstSearchEventTarget) not ]
		description: [ 'It is not possible to nest breadth first searches' ].
	target := aBlDevScripterEventTarget
]