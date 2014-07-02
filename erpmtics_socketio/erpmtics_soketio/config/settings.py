APP_ID = 'erpmtics_python_socketio'
PORT_DEFAULT = 3001

#ws://localhost:3000/socket.io/1/websocket/O0KuKNDJe0CyFQd4J0pr
#SOCKET_IO_HOST = "https://127.0.0.1"
#SOCKET_IO_HOST = "http://127.0.0.1"
#SOCKET_IO_HOST = "http://localhost"
SOCKET_IO_HOST = "localhost"
SOCKET_IO_PORT = 3001

#example haskey = hTCFsAiPFEgekOAfmOP_
#ws://localhost:3001/socket.io/1/websocket/hTCFsAiPFEgekOAfmOP_
SOCKET_IO_URL = 'ws://' + SOCKET_IO_HOST + ':' + str(SOCKET_IO_PORT) + '/socket.io/websocket/1'

# config that summarizes the above
SOKETIO_CONFIG = {
	'websocket'      : (APP_ID, PORT_DEFAULT)
	,'socketIO_client'      : (APP_ID, PORT_DEFAULT)
}

