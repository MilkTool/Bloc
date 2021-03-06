"
${class:BlLazyElement}$ lazily renders its child element deferring the rendering until the element actually becomes visible in the window.  E.g., if the window can be scrolled and the element is not visible, no action is taken.

!! Async Example With Simple Preview

The lazy element starts with the following temporary content:
${example:BlAsyncElementExamples>>#temporaryElement|noCode|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=80}$

And ends-up with the following final content:
${example:BlAsyncElementExamples>>#finalElement|noCode|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=80}$

Executing the following example shows the lazy element that at quickly change the content computed in the bacground:
${example:BlAsyncElementExamples>>#lazyElement|previewExpanded=false|previewShow=#gtLiveFor:|previewHeight=80}$

!! Sync Example

In particular cases, in which the lazy rendering needs to be disabled, ${class:BlUseAsyncFeatures}$ can be used as shown in the following example
${example:BlAsyncElementExamples>>#syncLazyElement|previewExpanded=false|previewShow=#gtLiveFor:|previewHeight=80}$

!! Async Example With Build-In Preview Support

${class:BlAsyncElement}$ includes a preview support that may be used if ${method:BlAsyncElement>>#withDelayedPreview|label=#selector}$ or ${method:BlAsyncElement>>#withDelayedPreview:|label=#selector}$ are called. See more details in the ${class:BlAsyncDelayedPreviewStrategy}$ class comment.

!! Public API and Key Messages

- elementBuilder:   a valuable, typically a BlockClosure, that returns the child element
 
!! Internal Representation and Key Implementation Points.

!!! Instance Variables
	element:				<BlElement>
	elementBuilder:		<BlockClosure>


"
Class {
	#name : #BlLazyElement,
	#superclass : #BlAsyncElement,
	#instVars : [
		'elementBuilder',
		'element',
		'postAction'
	],
	#category : #'Bloc-Async'
}

{ #category : #ui }
BlLazyElement >> buildElement [
	"Build the element and display it"

	self 
		assert: [ self elementBuilder isNotNil ]
		description: [ 'No element builder has been set' ].
	self element: self elementBuilder value.

]

{ #category : #accessing }
BlLazyElement >> element [
	^ element
]

{ #category : #accessing }
BlLazyElement >> element: aBlElement [
	"Set the receiver's element.
	If not nil, add it as a child"

	element := aBlElement.
	element ifNotNil: [
		| anAction |
		anAction := [ 
			self 
				removeChildren;
				addChild: element.
			self postAction cull: self cull: aBlElement.
			self invalidate ].
		BlUseAsyncFeatures 
			ifEnabledDo: [ 
				self enqueueTask: (BlTaskAction new action: anAction) ]
			otherwise: anAction ]
]

{ #category : #accessing }
BlLazyElement >> elementBuilder [
	^ elementBuilder
]

{ #category : #accessing }
BlLazyElement >> elementBuilder: aValuable [
	elementBuilder := aValuable.
	BlUseAsyncFeatures ifDisabledDo: [ self buildElement ].
]

{ #category : #initialization }
BlLazyElement >> initialize [
	super initialize.
	postAction := [ :theLazyElement :theChild | "do nothing" ].
]

{ #category : #testing }
BlLazyElement >> isAlreadyUpdated [
	"Return true if a child element is already present"
	<return: #Boolean>
	^ super isAlreadyUpdated or: [ self element isNotNil ]
]

{ #category : #'async processing' }
BlLazyElement >> mayQueueAsyncUpdate [
	self needsUpdate ifFalse: [ ^ self ].
	self queueAsyncUpdate
]

{ #category : #accessing }
BlLazyElement >> postAction [
	^ postAction
]

{ #category : #accessing }
BlLazyElement >> postAction: aTwoArgBlock [
	"An action that is executed right after an element is added as my child.
	It can be used to change my attibutes, e.g., background color.
	[ :theLazyElement :theChild | 'an action' ]."
	postAction := aTwoArgBlock
]

{ #category : #'async processing' }
BlLazyElement >> queueEntry [
	"Answer a TaskIt valuable that will update the receiver."

	^ ((BlTktUnresponsiveCommand new 
			valuable: (BlLazyElementValuable element: self);
			name: 'BlLazyElement(', self elementBuilder printString, ')';
			yourself) asBlTktSingleCommand
				identifier: self) asBlTktLoggingCommand


]

{ #category : #'async processing' }
BlLazyElement >> taskPool [
	^ BlTktWorkerProvider highUICPUBoundPool 
]
