
extends Control


# SCENE REFERENCES

@onready var screen_container: Control = $ScreenMargins/ScreenContainer
@onready var game_manager: Node = $GameManager

const LOBBY_SCENE = preload("res://host/Lobby.tscn")
const ROUND_INTRO_SCENE = preload("res://host/RoundIntro.tscn")
const ANSWER_PLAYBACK_SCENE = preload("res://host/AnswerPlayback.tscn")


# GAME DATA

var sound_library := SoundLibrary.new()
var current_sound_ids: Array[String] = []


# INITIALIZATION

func _ready() -> void:
	sound_library.load_library()
	
	# player adding tests
	game_manager.add_player("player_1", "Joseph")
	game_manager.add_player("player_2", "Maia")
	game_manager.add_player("player_3", "Meedo")
	game_manager.add_player("player_4", "Luis")
	
	show_lobby()
	
	print(game_manager.players)


# SCREEN MANAGEMENT

func clear_screen() -> void:
	for child in screen_container.get_children():
		screen_container.remove_child(child)
		child.queue_free()

func add_screen(screen: Control) -> void:
	screen_container.add_child(screen)
	screen.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

# LOBBY

func show_lobby() -> void:
	clear_screen()

	var lobby = LOBBY_SCENE.instantiate()
	add_screen(lobby)
	lobby.start_requested.connect(_on_start_requested)
	lobby.update_players(game_manager.players)


func _on_start_requested() -> void:
	show_round_intro()


# ROUND SETUP

func select_round_sounds() -> void:
	current_sound_ids = sound_library.select_random(5)


func show_round_intro() -> void:
	clear_screen()
	select_round_sounds()

	var sound_names: Array[String] = []
	var sound_streams: Array[AudioStream] = []

	for sound_id in current_sound_ids:
		sound_names.append(sound_library.get_sound_name(sound_id))
		sound_streams.append(sound_library.get_sound_stream(sound_id))

	var round_intro = ROUND_INTRO_SCENE.instantiate()
	add_screen(round_intro)

	round_intro.setup(1, "Worst Job Interview", sound_names)
	round_intro.continue_requested.connect(_on_continue_requested)
	round_intro.start_sound_sequence(sound_streams)


func _on_continue_requested() -> void:
	show_answer_playback()


# WRITING PHASE

# Coming next: Display prompt, timer, and submission status.

# ANSWER PLAYBACK


func show_answer_playback() -> void:
	clear_screen()

	var player1 := {
		"player_name": "jim",
		"texts": [
			"I walked into the interview and heard...",
			"The interviewer stood up and said...",
			"So I responded with..."
		],
		"sounds": [
			current_sound_ids[0],
			current_sound_ids[1],
			current_sound_ids[2]
		]
	}

	var player2 := {
		"player_name": "bob",
		"texts": [
			"My first question was...",
			"Then the office suddenly...",
			"And that's how I got fired because..."
		],
		"sounds": [
			current_sound_ids[2],
			current_sound_ids[3],
			current_sound_ids[4]
		]
	}

	var playback = ANSWER_PLAYBACK_SCENE.instantiate()
	add_screen(playback)

	playback.setup(
		"Worst Job Interview",
		player1,
		player2,
		sound_library
	)

	playback.continue_requested.connect(_on_playback_continue_requested)
	playback.play_matchup()


func _on_playback_continue_requested() -> void:
	print("Answer playback finished!")


# VOTING / SCORING

# Later: Display voting results and update scores.
