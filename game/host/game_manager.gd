extends Control

signal players_changed

var players: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_player(player_id: String, player_name: String) -> void:
	if players.has(player_id):
		return
	
	players[player_id] = {
		"name": player_name,
		# "avatar": avatar,
		"score": 0,
		"connected": true
	}
	
	players_changed.emit()

func remove_player(player_id) -> void:
	if players.has(player_id):
		players.erase(player_id)
		players_changed.emit()

func start_game() -> void:
	pass


func start_round() -> void:
	pass


func submit_answer(player_id, submission) -> void:
	pass

func submit_vote(player_id, matchup_id, choice) -> void:
	pass

func advance_phase() -> void:
	pass
