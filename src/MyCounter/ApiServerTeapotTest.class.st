Class {
	#name : #ApiServerTeapotTest,
	#superclass : #TestCase,
	#instVars : [
		'serverTest',
		'counterTest'
	],
	#category : #'MyCounter-Tests'
}

{ #category : #testing }
ApiServerTeapotTest >> setUp [
	counterTest := Counters new.
	counterTest createCounter: #counter1 with:10.
	counterTest createCounter: #counter2 with:100.
	counterTest createCounter: #counter3 with:1000.
	
	serverTest := Teapot on
	GET: '/ping' -> 'pong!';
	GET: '/counters/all' -> [ :req | NeoJSONWriter toString: counterTest getJsonCounters ];
	GET: '/counters/all/size' -> [ :req | counterTest counters size ];
	GET: '/counters/all/keys' -> [ :req | NeoJSONWriter toString: counterTest getKeys ];
	PATCH: '/counters/all/reset' -> [ :req | counterTest resetAllCounters ];
	DELETE: '/counters/all/remove' -> [ :req | counterTest removeAllCounters ];
	GET: '/counters/<id>' -> [ :req | counterTest getCounter: (req at:#id) ];
	PUT: '/counters/<id>' -> [ :req | counterTest createCounter: (req at:#id) with: (req at:#val) ];
	PATCH: '/counters/inc/<id>' -> [ :req | counterTest increment: (req at:#id) ];
	PATCH: '/counters/dec/<id>' -> [ :req | counterTest decrement: (req at:#id) ];
	PATCH: '/counters/reset/<id>' -> [ :req | counterTest resetCounter: (req at:#id) ];
	DELETE: '/counters/<id>' -> [ :req | counterTest removeCounter: (req at:#id) ];
	start.
	

	
	

]

{ #category : #testing }
ApiServerTeapotTest >> tearDown [ 
	serverTest stop.
	counterTest removeAllCounters.
	

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
	
	client url: 'http://localhost:1701/counters/dec/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '8'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testDeleteCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1'.
	 
	self assert: (client get) equals: '10'.
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
	
	client url: 'http://localhost:1701/counters/all'.
	dict := NeoJSONReader fromString: client get.
	self assert: (client response status) equals: 200. 
	
	self assert: dict class equals: Dictionary .
	self assert: dict size equals: 3 .
	self assert: (dict at: #counter1) equals: 10

	
]

{ #category : #testing }
ApiServerTeapotTest >> testGetCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter1'.
	 
	self assert: (client get) equals: '10'.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter2'.
	self assert: (client get) equals: '100'.
	
	client url: 'http://localhost:1701/counters/counter3'.
	self assert: (client get) equals: '1000'.
]

{ #category : #testing }
ApiServerTeapotTest >> testGetKeysCounters [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/all/keys'.
	client get.
	self assert: (client response status) equals: 200. 
	self assert: (NeoJSONReader fromString: client get) equals: counterTest getKeys.
	self assert: (NeoJSONReader fromString: client get) size equals: counterTest counters size.

	
]

{ #category : #testing }
ApiServerTeapotTest >> testGetSizeCounters [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/all/size'.
	 
	self assert: (client get) equals: (counterTest getKeys size asString ).
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testIncCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/inc/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '12'.
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
	
	client url: 'http://localhost:1701/counters/all/reset'.
	client patch.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter2'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	client url: 'http://localhost:1701/counters/counter3'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	
]

{ #category : #testing }
ApiServerTeapotTest >> testResetCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/reset/counter1'.
	client patch.
	self assert: (client response status) equals: 200.
		
	client url: 'http://localhost:1701/counters/counter1'. 
	self assert: (client get) equals: '0'.
	self assert: (client response status) equals: 200.
	

]

{ #category : #testing }
ApiServerTeapotTest >> testSetCounter [
	| client |
	client := ZnClient new.
	
	client url: 'http://localhost:1701/counters/counter4?val=110'.
	client put.
	self assert: (client response status) equals: 200.
	
	client url: 'http://localhost:1701/counters/counter4'. 
	self assert: (client get) equals: '110'.
	self assert: (client response status) equals: 200.
	
]
