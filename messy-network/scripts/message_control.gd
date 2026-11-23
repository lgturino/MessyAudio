extends Control

@onready var text_edit = $TextEdit
signal message_sent(content: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var submitted_text = text_edit.text 
	print("Sent: ", submitted_text)
	message_sent.emit(submitted_text)

	
