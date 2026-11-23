extends PanelContainer

@onready var text = $Label

func _on_message_control_message_sent(content: String) -> void:
	# need to duplicate, or else modifies the shared stylebox
	var style: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	style.bg_color = Color(randf(), randf(), randf())
	add_theme_stylebox_override("panel", style)

	text.text = content
	
