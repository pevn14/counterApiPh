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
	counters at: aString put: (Counter startingAt: anInteger).
]

{ #category : #action }
Counters >> decrement: aString [ 
	counters at: aString ifPresent: [ :x|x decrement ]
]

{ #category : #testing }
Counters >> existCounter: aString [ 
	^ counters includesKey: aString 
]

{ #category : #accessing }
Counters >> getCounter: aString [ 
	^ counters at: aString ifPresent: [ :x|x count ].
]

{ #category : #accessing }
Counters >> getKeys [
	^ counters keys
]

{ #category : #action }
Counters >> increment: aString [ 
	counters at: aString ifPresent: [ :x|x increment ]
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
	counters removeKey: aString
]

{ #category : #reseting }
Counters >> resetAllCounters [
	counters keys do: [ :k | (counters at:k) count:0 ]
]

{ #category : #reseting }
Counters >> resetCounter: aString [ 
	(counters at: aString) count:0
]
