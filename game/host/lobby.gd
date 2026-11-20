extends Control

signal start_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.pressed.connect(_on_start_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		pass

func _on_start_pressed() -> void:
	start_requested.emit()

func update_player_count(count: int) -> void:
	$VBoxContainer/PlayersLabel.text = "Players connected: %d" % count
