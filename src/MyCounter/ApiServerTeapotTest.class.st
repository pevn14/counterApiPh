Class {
	#name : #ApiServerTeapotTest,
	#superclass : #TestCase,
	#instVars : [
		'server'
	],
	#category : #'MyCounter-Tests'
}

{ #category : #testing }
ApiServerTeapotTest >> setUp [
	server := Teapot on
		GET: '/ping' -> 'pong!'; start.
	

]

{ #category : #testing }
ApiServerTeapotTest >> tearDown [ 
	server stop
	

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
