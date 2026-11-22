extends Control
const PLAYING_GAME = preload("uid://bn8oqj1fvtrxn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(PLAYING_GAME)
	pass # Replace with function body.
