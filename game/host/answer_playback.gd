extends Control

signal continue_requested

@onready var player_names: Array[Label] = [
	$VBoxContainer/HBoxContainer/Player1Panel/VBoxContainer/PlayerName,
	$VBoxContainer/HBoxContainer/Player2Panel/VBoxContainer/PlayerName
]

@onready var story_containers: Array[VBoxContainer] = [
	$VBoxContainer/HBoxContainer/Player1Panel/VBoxContainer/StoryContainer,
	$VBoxContainer/HBoxContainer/Player2Panel/VBoxContainer/StoryContainer
]

@onready var player_panels: Array[PanelContainer] = [
	$VBoxContainer/HBoxContainer/Player1Panel,
	$VBoxContainer/HBoxContainer/Player2Panel
]

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var continue_button: Button = $VBoxContainer/ContinueButton

var submissions: Array[Dictionary] = []
var sound_library: SoundLibrary

const TEXT_DURATION: float = 3.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)

func _on_continue_pressed() -> void:
	continue_requested.emit()

# SETUP

func setup(prompt: String, player1: Dictionary, player2: Dictionary, library: SoundLibrary) -> void:
	$VBoxContainer/PromptLabel.text = prompt

	submissions = [player1, player2]
	sound_library = library

	for i in range(2):
		player_names[i].text = submissions[i]["player_name"]
		create_story_display(i)

func create_story_display(player_index: int) -> void:
	var submission = submissions[player_index]
	var container = story_containers[player_index]

	var texts: Array = submission["texts"]
	var sounds: Array = submission["sounds"]

	for i in range(3):
		var text_label := CenteredLabel.new()
		text_label.text = texts[i]
		text_label.visible = false
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		container.add_child(text_label)

		var sound_label := CenteredLabel.new()
		sound_label.text = "🔊 " + sound_library.get_sound_name(sounds[i])
		container.add_child(sound_label)
		sound_label.visible = false

# STORY PLAYBACK

func reveal_player(player_index: int) -> void:
	var container = story_containers[player_index]
	var submission = submissions[player_index]

	var elements = container.get_children()
	var sounds: Array = submission["sounds"]

	for i in range(3):
		# Reveal the text.
		elements[i * 2].show()

		# Leave the text visible for 3 seconds.
		await get_tree().create_timer(TEXT_DURATION).timeout

		# Reveal and play the sound.
		elements[i * 2 + 1].show()

		audio_player.stream = sound_library.get_sound_stream(sounds[i])
		audio_player.play()

		# Wait until the sound finishes before continuing.
		await audio_player.finished

func play_matchup() -> void:
	continue_button.disabled = true

	# Start with both panels hidden.
	for panel in player_panels:
		panel.hide()

	for i in range(2):
		# Show only the player whose story is playing.
		player_panels[i].show()

		await reveal_player(i)

		# Hide the completed story before the next player.
		player_panels[i].hide()

	# Both stories have finished. Show them together.
	for panel in player_panels:
		panel.show()

	continue_button.disabled = false
