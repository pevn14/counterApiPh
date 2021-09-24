Class {
	#name : #CounterTest,
	#superclass : #TestCase,
	#category : #MyCounter
}

{ #category : #tests }
CounterTest >> testCounterDecrement [

| c |
c := Counter new.
c set: 4.
c decrement.
c decrement.
self assert: c get equals: 2
]

{ #category : #tests }
CounterTest >> testCounterIncrement [

| c |
c := Counter new.
c set: 4.
c increment.
c increment.
self assert: c get equals: 6
]

{ #category : #tests }
CounterTest >> testCounterSetAndGet [

| c |
c := Counter new.
c set: 7.
self assert: c get equals: 7
]
