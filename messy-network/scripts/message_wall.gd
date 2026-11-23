extends Control

const TEXTBOX_SCENE: PackedScene = preload("res://scenes/text_box.tscn")

@onready var messages: VBoxContainer = $ScrollContainer/Messages

func _on_message_sent(content: String) -> void:
	_add_message(content)


func _on_web_socket_client_message_received(message: Variant) -> void:
	_add_message(message)

func _add_message(content: String) -> void:
	var box := TEXTBOX_SCENE.instantiate() as PanelContainer
	messages.add_child(box)

	box.get_node("Label").text = content

	var style := box.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color = Color(randf(), randf(), randf())
	box.add_theme_stylebox_override("panel", style)
