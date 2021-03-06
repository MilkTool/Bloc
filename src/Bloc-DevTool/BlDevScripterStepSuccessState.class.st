Class {
	#name : #BlDevScripterStepSuccessState,
	#superclass : #BlDevScripterStepState,
	#category : #'Bloc-DevTool-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepSuccessState >> color [
	^ Color fromHexString: #b7eb8f
]

{ #category : #accessing }
BlDevScripterStepSuccessState >> name [
	^ 'success'
]

{ #category : #testing }
BlDevScripterStepSuccessState >> wasExecuted [
	<return: #Boolean>
	^ true
]
