extends Control

@onready var answer_1: HBoxContainer = $VBoxContainer/Answer1
@onready var answer_2: HBoxContainer = $VBoxContainer/Answer2
const END = preload("uid://b2ov066jomsxl")


func _ready() -> void:
	var rows := [answer_1, answer_2]
	for answer in SoundLibrary.answers:
		if answer["round"] != SoundLibrary.round_num:
			continue
		var row: HBoxContainer = rows[answer["player"] - 1]
		for i in 3:
			var text_box: TextEdit = row.get_node("Text%d" % (i + 1))
			text_box.text = answer["texts"][i]
			text_box.editable = false

			var sound_button: Button = row.get_node("Sound Pick %d" % (i + 1))
			var sound_index: int = answer["sounds"][i]
			sound_button.text = SoundLibrary.get_sound_name(sound_index)
			sound_button.pressed.connect(SoundLibrary.play.bind(sound_index))


func _on_button_pressed() -> void:
	SoundLibrary.round_num += 1
	if SoundLibrary.round_num > SoundLibrary.NUM_ROUNDS:
		# Game over. Final screen comes later; for now, restart.
		SoundLibrary.round_num = 1
		SoundLibrary.answers.clear()
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/playing_game.tscn")
