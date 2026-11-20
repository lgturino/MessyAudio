extends Control

@onready var screen_container: Control = $ScreenContainer

const LOBBY_SCENE = preload("res://host/Lobby.tscn")
const ROUND_INTRO_SCENE = preload("res://host/RoundIntro.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_lobby()

func clear_screen() -> void:
	for child in screen_container.get_children():
		screen_container.remove_child(child)
		child.queue_free()

func show_lobby() -> void:
	clear_screen()
	
	var lobby = LOBBY_SCENE.instantiate()
	screen_container.add_child(lobby)
	
	lobby.start_requested.connect(_on_start_requested)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_requested() -> void:
	show_round_intro()

func show_round_intro() -> void:
	clear_screen()
	
	var round_intro = ROUND_INTRO_SCENE.instantiate()
	screen_container.add_child(round_intro)

	round_intro.setup(1, "Worst Job Interview")
	round_intro.continue_requested.connect(_on_continue_requested)
	
	var test_sounds: Array[AudioStream] = [
		load("res://assets/soundboard_effects/shinese-gong.mp3"),
		load("res://assets/soundboard_effects/ohhh_yeahhh.mp3"),
		load("res://assets/soundboard_effects/fart-with-reverb.mp3")
	]
	
	round_intro.start_sound_sequence(test_sounds)

func _on_continue_requested() -> void:
	print("Round intro completed!")
