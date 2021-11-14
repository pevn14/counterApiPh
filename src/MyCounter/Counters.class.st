Class {
	#name : #Counters,
	#superclass : #Object,
	#instVars : [
		'counters'
	],
	#category : #'MyCounter-Core'
}

{ #category : #accessing }
Counters >> counters [
	^ counters
]

{ #category : #action }
Counters >> createCounter: aString with: anInteger [ 
	^counters at: aString asString put: (Counter startingAt: anInteger).
]

{ #category : #action }
Counters >> decrement: aString [ 
	^(counters at: aString ifAbsent:[ ^ nil ]) decrement
]

{ #category : #testing }
Counters >> existCounter: aString [ 
	^ counters includesKey: aString 
]

{ #category : #accessing }
Counters >> getCounter: aString [ 
	^ (counters at: aString ifAbsent:[ ^ nil ]) count
]

{ #category : #accessing }
Counters >> getJsonCounters [
	^ counters collect:  [ :item | item count ]
]

{ #category : #accessing }
Counters >> getKeys [
	^ counters keys
]

{ #category : #action }
Counters >> increment: aString [ 
	^(counters at: aString ifAbsent:[ ^ nil ]) increment 
]

{ #category : #initialization }
Counters >> initialize [
	  super initialize.
	  counters := Dictionary new
]

{ #category : #reseting }
Counters >> removeAllCounters [
	counters keys do: [ :k | counters removeKey: k ].
]

{ #category : #reseting }
Counters >> removeCounter: aString [ 
	counters removeKey: aString ifAbsent:[]
]

{ #category : #reseting }
Counters >> resetAllCounters [
	counters keys do: [ :k | (counters at:k) count:0 ]
]

{ #category : #reseting }
Counters >> resetCounter: aString [ 
	(counters at: aString ifAbsent:[ ^ nil ]) count:0
]
