
extends Control

signal continue_requested

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var sounds_container: VBoxContainer = $VBoxContainer/SoundsContainer
@onready var continue_button: Button = $VBoxContainer/ContinueButton

const SOUND_DELAY: float = 1.0

var sound_queue: Array[AudioStream] = []
var sound_buttons: Array[Button] = []
var sound_names: Array[String] = []
var sound_index: int = 0
var auto_playing: bool = false


func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)
	audio_player.finished.connect(_on_audio_finished)


# SETUP

func setup(round_number: int, prompt: String, names: Array[String]) -> void:
	$VBoxContainer/RoundLabel.text = "Round %d" % round_number
	$VBoxContainer/PromptLabel.text = prompt
	sound_names = names

	for child in sounds_container.get_children():
		child.queue_free()

	sound_buttons.clear()

	for i in range(names.size()):
		var button := Button.new()
		button.text = "%d. ???" % (i + 1)
		sounds_container.add_child(button)
		sound_buttons.append(button)
		button.disabled = true
		button.pressed.connect(_on_sound_pressed.bind(i))


# AUTOMATIC PLAYBACK

func start_sound_sequence(sounds: Array[AudioStream]) -> void:
	sound_queue = sounds
	sound_index = 0
	auto_playing = true
	continue_button.disabled = true

	play_next_sound()


func play_next_sound() -> void:
	if not auto_playing:
		return

	if sound_index >= sound_queue.size():
		auto_playing = false
		continue_button.disabled = false
		for button in sound_buttons:
			button.disabled = false
		print("All sounds finished!")
		return
	
	sound_buttons[sound_index].text = "%d. %s" % [
		sound_index + 1,
		sound_names[sound_index]
	]
	sound_buttons[sound_index].modulate = Color.YELLOW
	audio_player.stream = sound_queue[sound_index]
	sound_index += 1
	audio_player.play()


func _on_audio_finished() -> void:
	for button in sound_buttons:
		button.modulate = Color.WHITE
	
	if not auto_playing:
		return

	await get_tree().create_timer(SOUND_DELAY).timeout

	if auto_playing:
		play_next_sound()


# MANUAL PLAYBACK

func _on_sound_pressed(index: int) -> void:
	if index >= sound_queue.size():
		return

	auto_playing = false

	for button in sound_buttons:
		button.modulate = Color.WHITE

	sound_buttons[index].modulate = Color.YELLOW
	
	audio_player.stop()
	audio_player.stream = sound_queue[index]
	audio_player.play()


# NAVIGATION

func _on_continue_pressed() -> void:
	continue_requested.emit()
