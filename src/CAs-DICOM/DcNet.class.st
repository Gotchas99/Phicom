Class {
	#name : #DcNet,
	#superclass : #Object,
	#instVars : [
		'process',
		'port',
		'serverSocket'
	],
	#classVars : [
		'AlwaysRestart',
		'ManagedServers'
	],
	#classInstVars : [
		'default'
	],
	#category : #'CAs-DICOM-Net'
}

{ #category : #initialization }
DcNet class >> alwaysRestart [

	^ AlwaysRestart ifNil: [ AlwaysRestart := true ]
]

{ #category : #initialization }
DcNet class >> defaultOn: portNumber [

	"Return the default instance on a given port,
	Keep a reference to it in a class instance variable.
	If there was no previous default instance, create a new one.
	If there was a previous default instance, reuse it:
	if it was running stop it, change the port if necessary."

	^ default ifNil: [ default := self on: portNumber ] ifNotNil: [ 
		  default
			  stop;
			  port: portNumber;
			  yourself ]
]

{ #category : #initialization }
DcNet class >> defaultPortnumber [

	^ 11104
]

{ #category : #initialization }
DcNet class >> initialize [

	ManagedServers := IdentitySet new.
	AlwaysRestart := true.
	self environment
		at: #SessionManager
		ifPresent: [ :manager | 
		manager default registerNetworkClassNamed: self name ]
		ifAbsent: [ 
			Smalltalk
				addToStartUpList: self;
				addToShutDownList: self ].
	default := nil
]

{ #category : #'instance creation' }
DcNet class >> on: aNumber [

	"Instantiate and return a new listener on a given port,
	send #start to it to start listening."

	^ self new
		  port: aNumber;
		  yourself
]

{ #category : #initialization }
DcNet class >> reset [

	default ifNotNil: [ default stop.default := nil ].
	
]

{ #category : #'system startup' }
DcNet class >> shutDown: quitting [

	"Our system shutDown hook: stop all servers we manage"

	self traceCr: 'shutDown. quitting: ' , quitting printString.
	(quitting or: [ self alwaysRestart ]) ifTrue: [ 
		default
			ifNil: [ self traceCr: 'no default server found.' ]
			ifNotNil: [ default stop ] ].
"	self allInstances do: [ :srv | srv stop ]"
]

{ #category : #initialization }
DcNet class >> startDefault [

	"Start and return the default instance on a given port.
	Keep a reference to it in a class instance variable.
	If there was no previous default instance, create a new one.
	If there was a previous default instance, reuse it:
	if it was running stop and start it, effectively restarting it.
	Change the port if necessary.
	Starting the default server will register it automatically."

	^ (self startDefaultOn: self defaultPortnumber) yourself
]

{ #category : #initialization }
DcNet class >> startDefaultOn: portNumber [

	"Start and return the default instance on a given port.
	Keep a reference to it in a class instance variable.
	If there was no previous default instance, create a new one.
	If there was a previous default instance, reuse it:
	if it was running stop and start it, effectively restarting it.
	Change the port if necessary.
	Starting the default server will register it automatically."

	^ (self defaultOn: portNumber)
		  start;
		  yourself
]

{ #category : #'system startup' }
DcNet class >> startUp: resuming [

	self traceCr: 'startUp. resuming: ' , resuming printString.
	"Our system startUp hook: start all servers we manage.
	We do this using deferred startup actions to allow normal error handling."
	(resuming or: [ self alwaysRestart ]) ifTrue: [ 
		default ifNil:[self traceCr: 'no default server found.' .]ifNotNil: [ 
			self traceCr: 'default server found. starting it up' .
			SessionManager default currentSession addDeferredStartupAction: [ 
				self startDefault ] ] ]
]

{ #category : #initialization }
DcNet class >> stopDefault [

	"Stop and unregister the Default instance, if any, and clear it.
	Return the stopped instance, if any."

	| server |
	(server := default) ifNotNil: [ 
		default stop.
		default := nil ].
	^ server
]

{ #category : #accessing }
DcNet >> acceptWaitTimeout [

	"How many seconds to wait for a server socket listening for an accept ?"

	^ 30
]

{ #category : #validating }
DcNet >> checkLength: pdu [

	| buffstream b |
	b := ByteArray streamContents: [ :out | 
		     buffstream := ZnBufferedWriteStream on: out.
		     pdu writeOn: buffstream.
		     buffstream close ].
	Transcript
		trace: 'packetsize:';
		trace: b size;
		tab;
		trace: 'pdu_ext:';
		trace: pdu extLength.
	b size = pdu extLength ifFalse: [ Transcript
		trace: '******************************' ].
	Transcript cr
]

{ #category : #'request handling' }
DcNet >> executeOneRequestResponseOn: stream forAssoc: assoc [

	"Execute one single  request / response cycle on stream in 3 steps:
	#readRequest: #handleRequest: and #writeResponse:on:
	Indicate that we intend to close the connection afterwards"

	| request response |
	self traceCr:
		DateAndTime current asStringYMDHMS ,' ', self class name,' executeOneRequestResponseOn:'.
	request := DcPDU readFrom: stream.
	response := DcUpperLayerServer default
		            indication: request
		            forAssoc: assoc.
	ZnBufferedWriteStream
		on: stream
		do: [ :s | self writeResponse: response on: s ]
]

{ #category : #'request handling' }
DcNet >> executeRequestResponseLoopOn: stream [

	| assoc |
	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
		, ' executeRequestResponseLoopOn:'.
	assoc := DcAssociation new stream:stream.
	[ stream isConnected ] whileTrue: [ 
		self executeOneRequestResponseOn: stream forAssoc: assoc ]
]

{ #category : #private }
DcNet >> initializeServerSocket [

	serverSocket := Socket newTCP.
	serverSocket
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: 8000;
		setOption: 'SO_RCVBUF' value: 8000.
	serverSocket listenOn: self port backlogSize: 5.
	serverSocket isValid ifFalse: [ 
		self error: 'Cannot create socket on port ' , port printString ]
]

{ #category : #testing }
DcNet >> isRunning [

	"Return true when I am running"

	^  process notNil and: [  serverSocket notNil ]
]

{ #category : #'request handling' }
DcNet >> listenLoop [

	"We create a listening Socket, then wait for a connection.
	After each connection we also check that the listening Socket is still valid 
	- if not we just make a recursive call to this method to start over."

	self traceCr: DateAndTime current asStringYMDHMS,' listenLoop ======================='.
	self initializeServerSocket.
	[ 
	[ 
	serverSocket isValid ifFalse: [ "will trigger #ifCurtailed: block and destroy socket"
		self traceCr: 'serverSocket invalid ----------------------------'.
		^ self listenLoop ].
	"self traceCr:
		'before serveConnectionsOn ----------------------------'."
	self serveConnectionsOn: serverSocket ] repeat ] ensure: [ "ensure var tidigare ifCurtailed"
		self traceCr: 'listenloop ended (ensure:). releaseServerSocket'.
		self releaseServerSocket ].
	self traceCr: 'After serveConnectionsOn ----------------------------'
]

{ #category : #accessing }
DcNet >> port [

	"Return the integer port number we are (or will be) listening on"

	^ port 
]

{ #category : #accessing }
DcNet >> port: aninteger [

port:=aninteger
]

{ #category : #printing }
DcNet >> printOn: stream [

	super printOn: stream.
	stream nextPut: $(.
	stream nextPutAll: (self isRunning
			 ifTrue: [ 'running' ]
			 ifFalse: [ 'stopped' ]).
	 port ifNotNil: [ :p | 
		stream
			space;
			print: p ].
	"self bindingAddress ifNotNil: [ :bindingAddress | 
		stream
			space; 
			print: bindingAddress ]."
	stream nextPut: $)
]

{ #category : #private }
DcNet >> releaseServerSocket [

	"Release our server socket"

	| address |
	self traceCr: 'Release our server socket'.
	serverSocket ifNil: [ ^ self ].
	address := [ serverSocket address ]
		           on: Error
		           do: [ nil ]. 
	port := [ serverSocket port ]
		        on: Error
		        do: [ nil ].
	(Delay forMilliseconds: 10) wait.
	serverSocket destroy.
	serverSocket := nil
]

{ #category : #'request handling' }
DcNet >> sendPDU: aPdu forAssoc: assoc [

	self traceCr:
		DateAndTime current asStringYMDHMS , ' ' , self class name
		, ' sendPDU:'.

	ZnBufferedWriteStream
		on: assoc stream
		do: [ :s | aPdu writeOn: s ]
]

{ #category : #'request handling' }
DcNet >> serveConnectionOn: socket [

	| stream |
	stream := self socketStreamOn: socket.
	[ 
	[ self executeRequestResponseLoopOn: stream ]
		on: ConnectionClosed , ConnectionTimedOut
		do: [ :ex | 
			Transcript
				show:
					DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
					, 'serveConnectionOn: Connection error. Closing stream';
				cr ] ] ensure: [ 
		self traceCr:
			DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
					, 'serveConnectionOn: closing stream'.
		stream close ]
]

{ #category : #'request handling' }
DcNet >> serveConnectionsOn: listeningSocket [

	"We wait up to acceptWaitTimeout seconds for an incoming connection.
	If we get one we wrap it in a SocketStream and #executeOneRequestResponseOn: on it.
	We do not fork a worker thread/process but stay in the current one for just one 
	request/response cycle."

	| socket |
	"self traceCr: 'serveConnectionsOn: waiting for connection '
		, DateAndTime current printString."
	socket := listeningSocket waitForAcceptFor: self acceptWaitTimeout.
	socket ifNil: [ 
		"self traceCr: 'no accepted connection'."
		^ self ].
	self traceCr: 'serveConnectionsOn: accepted connection'.
	[ 
	self traceCr: 'serveConnectionsOn:process started **************'.
	self serveConnectionOn: socket.
	self traceCr: 'serveConnectionsOn:process stopped **************' ]
		forkAt: 32
		named: 'serveConnectionsOn'.
	^ self
]

{ #category : #printing }
DcNet >> serverProcessName [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: self class name;
			  nextPutAll: ' DICOM port ';
			  print: self port ]
]

{ #category : #private }
DcNet >> setSocketStreamParameters: stream [

	stream
		binary;
		shouldSignal: true;
		autoFlush: false;
		bufferSize: self socketBufferSize;
		timeout: 30
]

{ #category : #accessing }
DcNet >> socketBufferSize [

	"Size in bytes for Sockets and SocketStream IO buffers"

	^ 4096
]

{ #category : #private }
DcNet >> socketStreamOn: socket [

	| stream |
	stream :=  SocketStream on: socket.
	self setSocketStreamParameters: stream.
	^ stream
]

{ #category : #public }
DcNet >> start [

	process := [ self traceCr: 'serverprocess started **************'.[ self listenLoop ] repeat.self traceCr: 'serverprocess stopped **************' ]
		           forkAt: 33
		           named: self serverProcessName. "highIOPriority"
	self traceCr: 'serverprocess forked **************'
]

{ #category : #public }
DcNet >> stop [

	"Stop me. I will stop listening on my port for incoming HTTP connections.
	If unregister is true, unregister me from the list of managed instances.
	Does nothing when I am not running"

	self isRunning ifFalse: [ ^ self ].
	process terminate.
	process := nil.	self traceCr: 'server stopped **************'
]

{ #category : #'request handling' }
DcNet >> writeResponse: response on: stream [

	response
		ifNil: [ 
			self traceCr:
				DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
				, 'Empty response. Not written' ]
		ifNotNil: [ 
			response writeOn: stream.
			self traceCr: DateAndTime current asStringYMDHMS , ' ' , self class name , ' '
				,'Response sent' ]
]
