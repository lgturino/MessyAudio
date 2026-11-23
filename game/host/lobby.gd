extends Control

signal start_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	start_requested.emit()

func update_players(players: Dictionary) -> void:
	var count = 0
	for child in $VBoxContainer/PlayerList.get_children():
		$VBoxContainer/PlayerList.remove_child(child)
		child.queue_free()
	
	for player in players.values():
		if player["connected"]:
			count += 1
			var text_label := CenteredLabel.new()
			text_label.text = player["name"]
			$VBoxContainer/PlayerList.add_child(text_label)
			
	$VBoxContainer/PlayerCountLabel.text = "Players connected: %d" % count
