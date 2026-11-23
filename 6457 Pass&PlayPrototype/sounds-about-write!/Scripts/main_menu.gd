extends Control
const GAME_START = preload("uid://bnf2etskqkdln")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	# Change to a differtent screen
	get_tree().change_scene_to_packed(GAME_START)
	pass # Replace with function body.



func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
