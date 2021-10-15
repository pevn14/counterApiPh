Class {
	#name : #CounterTest,
	#superclass : #TestCase,
	#category : #'MyCounter-Tests'
}

{ #category : #tests }
CounterTest >> testAllMethods [
| c |
c := Counter startingAt: 1.
self assert: (c decrement ; decrement ; count) equals: -1
]

{ #category : #tests }
CounterTest >> testCounterDecrement [

| c |
c := Counter new.
c count: 4.
c decrement.
c decrement.
self assert: c count equals: 2
]

{ #category : #tests }
CounterTest >> testCounterIncrement [

| c |
c := Counter new.
c count: 4.
c increment.
c increment.
self assert: c count equals: 6
]

{ #category : #tests }
CounterTest >> testCounterSetAndGet [

| c |
c := Counter new.
c count: 7.
self assert: c count equals: 7
]

{ #category : #tests }
CounterTest >> testInitialize [
| c |
c := Counter new.
self assert: c count equals: 0
]

{ #category : #tests }
CounterTest >> testStartingAtFive [
| c |
c := Counter startingAt: 5.
self assert: c count equals: 5
]
