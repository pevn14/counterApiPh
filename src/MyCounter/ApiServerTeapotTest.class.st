Class {
	#name : #ApiServerTeapotTest,
	#superclass : #TestCase,
	#instVars : [
		'serverTest'
	],
	#category : #'MyCounter-Tests'
}

{ #category : #testing }
ApiServerTeapotTest >> setUp [
	serverTest := ApiServerTeapot createAt: 1701.
	serverTest start.
	
	
]

{ #category : #testing }
ApiServerTeapotTest >> tearDown [ 
	serverTest stop.
	

]

{ #category : #testing }
ApiServerTeapotTest >> test404 [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/pin'.
	client get.
	self assert: (client response status) equals: 404
]

{ #category : #testing }
ApiServerTeapotTest >> testDecCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '100'.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/dec/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '98'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testDeleteCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter1'.
	 
	self assert: (client get) equals: '100'.
	self assert: (client response status) equals: 200.
	
	client delete.
	self assert: (client response status) equals: 200.
	
	self assert: (client get) equals: 'nil'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testGetAllCounters [
	| client dict |
	client := ZnClient new.
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter2?val=200'.
	client put.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter3?val=300'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/all'.
	dict := NeoJSONReader fromString: client get.
	self assert: (client response status) equals: 200. 
	
	self assert: dict class equals: Dictionary .
	self assert: dict size equals: 3 .
	
	self assert: (dict at: #counter1) equals: 100.
	self assert: (dict at: #counter2) equals: 200.
	self assert: (dict at: #counter3) equals: 300.
]

{ #category : #testing }
ApiServerTeapotTest >> testGetInexisting [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counterInexisting'. 
	self assert: (client get) equals: 'nil'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testGetKeysCounters [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=10'.
	client put.
	client url: 'http://localhost:1701/counters/counter2?val=100'.
	client put.
	client url: 'http://localhost:1701/counters/counter3?val=1000'.
	client put.
	
	client url: 'http://localhost:1701/counters/all/keys'.
	client get.
	self assert: (client response status) equals: 200. 
	self assert: (NeoJSONReader fromString: client get) size equals: 3.
	self assert: ((NeoJSONReader fromString: client get)class ) equals: Array.


	
]

{ #category : #testing }
ApiServerTeapotTest >> testGetSizeCounters [
	| client |
	client := ZnClient new.
	client url: 'http://localhost:1701/counters/all/remove'.
	client delete.
	
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter2?val=200'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/all/size'.
	 
	self assert: (client get) equals: '2'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testIncCounter [
	| client |
	client := ZnClient new.
	client url: 'http://localhost:1701/counters/counter1?val=110'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '110'.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/inc/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '112'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testIsConnected [
	| client |
	client := ZnClient new.
	client url: 'http://localhost:1701';	get.
	 
	self assert: (client isConnected) equals: true.
]

{ #category : #testing }
ApiServerTeapotTest >> testPing [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/ping'.
	 
	self assert: (client get) equals: 'pong!'.
	self assert: (client response status) equals: 200
]

{ #category : #testing }
ApiServerTeapotTest >> testRemoveAllCounters [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/all/remove'.
	client delete.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'.
		self assert: (client get) equals: 'nil'.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter2'. 
		self assert: (client get) equals: 'nil'.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter3'. 
		self assert: (client get) equals: 'nil'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testResetAllCounters [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter2?val=200'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/all/reset'.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter2'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.

	
]

{ #category : #testing }
ApiServerTeapotTest >> testResetCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/reset/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
		
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testResetInexistingCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/reset/counter1475'.
	self assert: (client patch) equals: 'nil'.
	self assert: (client response status) equals: 200.
	
		
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '100'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testSetAndGetCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=100'.
	client put.
	client url: 'http://localhost:1701/counters/counter2?val=200'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '100'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testSetwithNoInteger [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1?val=hello'.
	client put.
	self assert: (client response status) equals: 500.
	
	
]
