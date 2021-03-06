"
I define common action steps
"
Trait {
	#name : #TBlDevScripterActionStep,
	#traits : 'TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> click [
	^ self addStep: (BlDevScripterClickStep new referenceSender)
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> do [
	^ self addStep: BlDevScripterActionStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> fire [
	^ self addStep: BlDevScripterFireEventStep new referenceSender
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> set [
	^ self addStep: BlDevScripterSetStep new referenceSender
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substep: aLabel do: anOneArgBlock [
	^ self substeps: aLabel do: anOneArgBlock
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps [
	^ self addStep: (BlDevScripterMultipleActionStep new referenceSender)
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps: aLabel [
	^ self substeps
		label: aLabel;
		referenceSender
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substeps: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self substeps
		label: aLabel;
		referenceSender.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type [
	^ self addStep: BlDevScripterTypeTextStep new referenceSender
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type: aString [
	^ self type 
		text: aString;
		referenceSender
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> wait [
	^ self addStep: BlDevScripterWaitStep new referenceSender
]
