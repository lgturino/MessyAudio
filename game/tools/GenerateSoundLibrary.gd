@tool
extends EditorScript

const SOUND_FOLDER := "res://assets/soundboard_effects/"
const OUTPUT_FILE := "res://assets/soundboard_effects/sounds.json"

const SUPPORTED_FORMATS := ["mp3", "wav"]


func _run() -> void:
	var directory := DirAccess.open(SOUND_FOLDER)

	if directory == null:
		push_error("Sound folder not found: " + SOUND_FOLDER)
		return

	var library: Dictionary = {}

	for filename in DirAccess.get_files_at(SOUND_FOLDER):
		var extension := filename.get_extension().to_lower()

		if extension not in SUPPORTED_FORMATS:
			continue

		var base_name := filename.get_basename()
		var sound_id := base_name.to_lower().replace(" ", "_").replace("-", "_")
		var display_name := base_name.replace("_", " ").replace("-", " ")

		if library.has(sound_id):
			push_warning("Duplicate sound ID: " + sound_id)
			continue

		library[sound_id] = {
			"name": display_name,
			"path": SOUND_FOLDER + filename
		}

	if library.is_empty():
		push_error("No sound effects found.")
		return

	var file := FileAccess.open(OUTPUT_FILE, FileAccess.WRITE)

	if file == null:
		push_error("Could not write: " + OUTPUT_FILE)
		return

	file.store_string(JSON.stringify(library, "\t"))
	file.close()

	print("Sound library generated: ", library.size(), " effects")
