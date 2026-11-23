extends Button

@onready var server := $WebSocketServer

func _button_pressed() -> void:
	server.listen(9123)
	print("Listening")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


func _on_web_socket_server_message_received(peer_id: int, message: String) -> void:
	# relay to all other clients
	server.send(-peer_id, message)


func _on_web_socket_server_client_connected(peer_id: int) -> void:
	print("Connected", peer_id)
