extends RefCounted
class_name SoundLibrary

var sounds: Dictionary = {}


func load_library() -> void:
	var file := FileAccess.open("res://assets/soundboard_effects/sounds.json", FileAccess.READ)

	if file == null:
		push_error("Could not open sound library.")
		return

	var json_text := file.get_as_text()
	var parsed = JSON.parse_string(json_text)

	if parsed is Dictionary:
		sounds = parsed
	else:
		push_error("Invalid sound library JSON.")


func select_random(count: int) -> Array[String]:
	var ids: Array[String] = []

	for id in sounds.keys():
		ids.append(id)

	ids.shuffle()

	if ids.size() < count:
		push_warning("Not enough sounds in library.")

	return ids.slice(0, min(count, ids.size()))


func get_sound_name(id: String) -> String:
	return sounds[id].get("name", id)


func get_sound_stream(id: String) -> AudioStream:
	var path: String = sounds[id]["path"]
	return load(path) as AudioStream
