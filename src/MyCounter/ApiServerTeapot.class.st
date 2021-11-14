Class {
	#name : #ApiServerTeapot,
	#superclass : #Teapot,
	#category : #'MyCounter-Server'
}

{ #category : #accessing }
ApiServerTeapot class >> createAt: aInteger [
	| counters server |
	counters := Counters new.
	
	server:= Teapot configure: {#port -> aInteger}.
	server 
	GET: '/ping' -> 'pong!';
	GET: '/counters/all' -> [ :req | NeoJSONWriter toString: counters getJsonCounters ];
	GET: '/counters/all/size' -> [ :req | counters counters size ];
	GET: '/counters/all/keys' -> [ :req | NeoJSONWriter toString: counters getKeys ];
	PATCH: '/counters/all/reset' -> [ :req | counters resetAllCounters ];
	DELETE: '/counters/all/remove' -> [ :req | counters removeAllCounters ];
	GET: '/counters/<id>' -> [ :req | counters getCounter: (req at:#id) ];
	PUT: '/counters/<id>' -> [ :req | counters createCounter: (req at:#id) with: (req at:#val) asInteger ];
	PATCH: '/counters/inc/<id>' -> [ :req | counters increment: (req at:#id) ];
	PATCH: '/counters/dec/<id>' -> [ :req | counters decrement: (req at:#id) ];
	PATCH: '/counters/reset/<id>' -> [ :req | counters resetCounter: (req at:#id) ];
	DELETE: '/counters/<id>' -> [ :req | counters removeCounter: (req at:#id) ].
	^ server 
]
