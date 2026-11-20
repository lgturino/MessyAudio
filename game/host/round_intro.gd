extends Control

signal continue_requested

func setup(round_number: int, prompt: String) -> void:
	$VBoxContainer/RoundLabel.text = "Round %d" % round_number
	$VBoxContainer/PromptLabel.text = prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)
	audio_player.finished.connect(_on_audio_finished)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_continue_pressed() -> void:
	continue_requested.emit()

##### Sound Bite Playback #####
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

const SOUND_DELAY: float = 1.0

var sound_queue: Array[AudioStream] = []
var sound_index: int = 0

func start_sound_sequence(sounds: Array[AudioStream]) -> void:
	sound_queue = sounds
	sound_index = 0
	play_next_sound()

func play_next_sound() -> void:
	if sound_index >= sound_queue.size():
		print("All sounds finished!")
		return

	audio_player.stream = sound_queue[sound_index]
	sound_index += 1
	audio_player.play()
	

func _on_audio_finished() -> void:
	await get_tree().create_timer(SOUND_DELAY).timeout
	play_next_sound()
