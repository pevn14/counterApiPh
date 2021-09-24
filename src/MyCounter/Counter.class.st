Class {
	#name : #Counter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #MyCounter
}

{ #category : #accessing }
Counter class >> startingAt: anInteger [

	^ self new set: anInteger 
	
]

{ #category : #accessing }
Counter >> decrement [ 
	count:= count -1 
	
]

{ #category : #accessing }
Counter >> get [

	  ^ count 
	
]

{ #category : #accessing }
Counter >> increment [
	count:= count +1 
	
]

{ #category : #accessing }
Counter >> initialize [
	
	  super initialize.
	  count := 0
	 
	
]

{ #category : #accessing }
Counter >> printOn: aStream [
	
	super printOn: aStream.
	aStream nextPutAll: ' with value:  ' , count printString.
	aStream cr 
	 
	
]

{ #category : #accessing }
Counter >> set: anInteger [ 

	  count := anInteger 
	
]
