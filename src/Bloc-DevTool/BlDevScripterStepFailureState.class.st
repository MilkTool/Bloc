Class {
	#name : #BlDevScripterStepFailureState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepFailureState >> color [
	^ Color fromHexString: #ffa39e
]

{ #category : #accessing }
BlDevScripterStepFailureState >> name [
	^ 'failed'
]

{ #category : #testing }
BlDevScripterStepFailureState >> wasExecuted [
	<return: #Boolean>
	^ true
]
