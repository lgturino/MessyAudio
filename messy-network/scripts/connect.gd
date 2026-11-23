extends Button

@onready var client := $WebSocketClient

func _button_pressed() -> void:
	client.connect_to_url("ws://localhost:9123")
	print("Connected")
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_message_control_message_sent(content: String) -> void:
	client.send(content)
