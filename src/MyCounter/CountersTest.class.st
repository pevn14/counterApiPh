Class {
	#name : #CountersTest,
	#superclass : #TestCase,
	#category : #'MyCounter-Tests'
}

{ #category : #'tests - loading' }
CountersTest >> testCreate1000Counters [
| c n |
c := Counters new.

n := 1000.
(1 to: n) do:[ :i | |key|
	key := ('counter', i asString) asSymbol .
	c createCounter: key with: i*i 	
	].

self assert: c counters class equals: Dictionary .
self assert: c counters size equals: n .
self assert: (c getCounter: #counter1) equals:1.
self assert: (c getCounter: #counter1000) equals:1000*1000.

c removeAllCounters.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 0.



]

{ #category : #tests }
CountersTest >> testCreateAndGetKey [
| c keys |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: #counter2 with:100.
c createCounter: #counter3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.
keys := c getKeys.
self assert: keys size equals:3.
self assert: (keys includes: #counter1) equals:true.
self assert: (keys includes: #counter4) equals:false.
]

{ #category : #tests }
CountersTest >> testCreateAndGetValue [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.
self assert: (c getCounter: 'counter1') equals:10.
self assert: (c getCounter: 'counter2') equals:100.
self assert: (c getCounter: '3') equals:1000.
]

{ #category : #tests }
CountersTest >> testExistCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10.

self assert: (c existCounter: #counter1) equals:true.
self assert: (c existCounter: #counter2) equals:false.

]

{ #category : #tests }
CountersTest >> testGetInexistingCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: #counter2 with:100.

self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 2.
self assert: (c getCounter: #counter1) equals:10.
self assert: (c getCounter: #counter2) equals:100.
self assert: (c getCounter: #counter3) equals:nil.

]

{ #category : #tests }
CountersTest >> testGetJsonCounters [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.

self assert: c getJsonCounters class equals: Dictionary.
self assert: c getJsonCounters size equals: 3.

self assert: (c getJsonCounters at: 'counter2' ) equals: 100.


]

{ #category : #tests }
CountersTest >> testIncDecCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10;
  createCounter: #counter2 with:100.

c increment: #counter1 ;
  decrement: #counter2 ; decrement: #counter2.

self assert: (c getCounter: #counter1) equals:11.
self assert: (c getCounter: #counter2) equals:98.

]

{ #category : #tests }
CountersTest >> testIncDecInexistingCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10.

c increment: #counter1 .
self assert: (c getCounter: #counter1) equals:11.
c decrement: #counter1 ; decrement: #counter1 .
self assert: (c getCounter: #counter1) equals:9.

c increment: #counter2 .
self assert: (c getCounter: #counter2) equals:nil.
c decrement: #counter2 .
self assert: (c getCounter: #counter2) equals:nil.

]

{ #category : #tests }
CountersTest >> testInitialize [
| c |
c := Counters new.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 0.
]

{ #category : #tests }
CountersTest >> testMultiCountersCreateAndGetValue [
| c1 c2 c3 |
c1 := Counters new.
c2 := Counters new.
c3 := Counters new.
c1 createCounter: #counter1 with:10.
c1 createCounter: #counter2 with:100.
c1 createCounter: #counter3 with:1000.
c2 createCounter: #counter1 with:20.
c2 createCounter: #counter2 with:200.
self assert: c1 counters class equals: Dictionary .
self assert: c1 counters size equals: 3.
self assert: c2 counters class equals: Dictionary .
self assert: c2 counters size equals: 2.
self assert: c3 counters class equals: Dictionary .
self assert: c3 counters size equals: 0.

self assert: (c1 getCounter: #counter1) equals:10.
self assert: (c2 getCounter: #counter1) equals:20.
self assert: (c3 getCounter: #counter1) equals:nil.

]

{ #category : #tests }
CountersTest >> testOverideValue [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.

self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 2.
self assert: (c getCounter: #counter1) equals:10.
self assert: (c getCounter: 'counter2') equals:100.

c createCounter: 'counter2' with:200.
self assert: c counters size equals: 2.
self assert: (c getCounter: #counter1) equals:10.
self assert: (c getCounter: 'counter2') equals:200.
]

{ #category : #tests }
CountersTest >> testRemoveAllCounters [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.

c removeAllCounters.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 0.


]

{ #category : #tests }
CountersTest >> testRemoveCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.

c removeCounter:#counter1.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 2.


]

{ #category : #tests }
CountersTest >> testResetAllCounters [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.
self assert: (c getCounter: '3') equals:1000.
c resetAllCounters.
self assert: (c getCounter: #counter1) equals:0.
self assert: (c getCounter: 'counter2') equals:0.
self assert: (c getCounter: '3') equals:0.
]

{ #category : #tests }
CountersTest >> testResetCounter [
| c |
c := Counters new.
c createCounter: #counter1 with:10.
c createCounter: 'counter2' with:100.
c createCounter: 3 with:1000.
self assert: c counters class equals: Dictionary .
self assert: c counters size equals: 3.

c resetCounter:#counter1.
self assert: (c getCounter: #counter1) equals:0.
self assert: (c getCounter: 'counter2') equals:100.
self assert: (c getCounter: '3') equals:1000.
]
