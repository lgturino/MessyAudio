extends Control
@onready var sound_1: Button = $VBoxContainer/SoundContainer/Sound1
@onready var sound_2: Button = $VBoxContainer/SoundContainer/Sound2
@onready var sound_3: Button = $VBoxContainer/SoundContainer/Sound3
@onready var sound_4: Button = $VBoxContainer/SoundContainer/Sound4
@onready var sound_5: Button = $VBoxContainer/SoundContainer/Sound5


@onready var sound_pick_1: OptionButton = $"VBoxContainer/Answer/Sound Pick 1"
@onready var sound_pick_2: OptionButton = $"VBoxContainer/Answer/Sound Pick 2"
@onready var sound_pick_3: OptionButton = $"VBoxContainer/Answer/Sound Pick 3"

@onready var submit_button: Button = $VBoxContainer/SubmitButton
const RESULTS = preload("uid://bfy50wcwreb0a")


const NUM_PLAYERS := 2
const NUM_ROUNDS := 3

var player: int = 1
var picks: Array[int] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_sounds()
	update_submit_text()


func setup_sounds() -> void:
	picks = SoundLibrary.fetch_random_sounds(5)
	var buttons := [sound_1, sound_2, sound_3, sound_4, sound_5]
	for i in 5:
		buttons[i].text = SoundLibrary.get_sound_name(picks[i])
	for dropdown in [sound_pick_1, sound_pick_2, sound_pick_3]:
		dropdown.clear()
		for index in picks:
			dropdown.add_item(SoundLibrary.get_sound_name(index), index)


func update_submit_text() -> void:
	submit_button.text = "Round %d: Submit (Player %d)" % [SoundLibrary.round_num, player]




func _on_sound_1_pressed() -> void:
	SoundLibrary.play(picks[0])
	pass # Replace with function body.


func _on_sound_2_pressed() -> void:
	SoundLibrary.play(picks[1])
	pass # Replace with function body.


func _on_sound_3_pressed() -> void:
	SoundLibrary.play(picks[2])
	pass # Replace with function body.


func _on_sound_4_pressed() -> void:
	SoundLibrary.play(picks[3])
	pass # Replace with function body.


func _on_sound_5_pressed() -> void:
	SoundLibrary.play(picks[4])
	pass # Replace with function body.


func _on_sound_pick_1_item_selected(index: int) -> void:
	SoundLibrary.play(picks[index])


func _on_sound_pick_2_item_selected(index: int) -> void:
	SoundLibrary.play(picks[index])


func _on_sound_pick_3_item_selected(index: int) -> void:
	SoundLibrary.play(picks[index])

@onready var text_1: TextEdit = $VBoxContainer/Answer/Text1
@onready var text_2: TextEdit = $VBoxContainer/Answer/Text2
@onready var text_3: TextEdit = $VBoxContainer/Answer/Text3

func _on_submit_button_pressed() -> void:
	SoundLibrary.answers.append({
		"round": SoundLibrary.round_num,
		"player": player,
		"texts": [text_1.text, text_2.text, text_3.text],
		"sounds": [sound_pick_1.get_selected_id(), sound_pick_2.get_selected_id(), sound_pick_3.get_selected_id()],
	})
	text_1.clear()
	text_2.clear()
	text_3.clear()

	player += 1
	if player > NUM_PLAYERS:
		get_tree().change_scene_to_file("res://Scenes/results.tscn")
		return

	update_submit_text()
