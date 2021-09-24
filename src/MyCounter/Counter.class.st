Class {
	#name : #Counter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #MyCounter
}

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
Counter >> set: anInteger [ 

	  count := anInteger 
	
]