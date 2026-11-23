extends Node
## Global sound library. Add as an autoload named "SoundLibrary"
## (Project -> Project Settings -> Globals).
##
## Usage from any script:
##   var picks := SoundLibrary.fetch_random_sounds(5)   # e.g. [12, 3, 17, 0, 8]
##   SoundLibrary.play(picks[0])
##   label.text = SoundLibrary.get_sound_name(picks[0])

const SOUND_DIR := "res://Assests/Sounds/"
const NUM_ROUNDS := 3
var round_num: int = 1
var answers: Array = []
# Each entry: display name shown to players + preloaded audio.
# preload() checks every path when the game loads, so a typo in a
# filename shows up as an error immediately instead of mid-game.
const SOUNDS := [
	{"name": "Glass Breaking", "stream": preload(SOUND_DIR + "glass-breaking-sound-effect_wLZSIYn.mp3")},
	{"name": "Fart", "stream": preload(SOUND_DIR + "fart-with-reverb.mp3")},
	{"name": "FAAAH", "stream": preload(SOUND_DIR + "faaah.mp3")},
	{"name": "Explosion", "stream": preload(SOUND_DIR + "exploded_zfp5Xgm.mp3")},
	{"name": "Emotional Damage", "stream": preload(SOUND_DIR + "emotional-damage-meme.mp3")},
	{"name": "Drift", "stream": preload(SOUND_DIR + "drift-sound-effect_56hbeZG.mp3")},
	{"name": "City Traffic", "stream": preload(SOUND_DIR + "city_traffic.mp3")},
	{"name": "Cash Register", "stream": preload(SOUND_DIR + "cash_register.mp3")},
	{"name": "Slide Whistle", "stream": preload(SOUND_DIR + "cartoon_slide_whistle.mp3")},
	{"name": "Ricochet", "stream": preload(SOUND_DIR + "cartoon_ricochet.mp3")},
	{"name": "Pop", "stream": preload(SOUND_DIR + "cartoon_pop.mp3")},
	{"name": "Among Us Reveal", "stream": preload(SOUND_DIR + "among-us-role-reveal-sound.mp3")},
	{"name": "Record Scratch", "stream": preload(SOUND_DIR + "Wild_Record_Scratches.mp3")},
	{"name": "Siren", "stream": preload(SOUND_DIR + "Siren.mp3")},
	{"name": "Tee Hee", "stream": preload(SOUND_DIR + "Cute_Tee_Hee.mp3")},
	{"name": "Bruh", "stream": preload(SOUND_DIR + "Bruh.mp3")},
	{"name": "Clown Horn", "stream": preload(SOUND_DIR + "high_pitch_clown_horn.mp3")},
	{"name": "Mario", "stream": preload(SOUND_DIR + "goofy-ahh-mario-sounds-mp3.mp3")},
	{"name": "Minecraft Eating", "stream": preload(SOUND_DIR + "minecraft-eating-sounds-meme-mp3-idk.mp3")},
	{"name": "Boing", "stream": preload(SOUND_DIR + "jaw_harp_wacky_boing.mp3")},
	{"name": "Violin Screech", "stream": preload(SOUND_DIR + "violin-screech-meme.mp3")},
	{"name": "Nemesis", "stream": preload(SOUND_DIR + "tf_nemesis.mp3")},
	{"name": "Suggestive Whistle", "stream": preload(SOUND_DIR + "suggestive_whistle.mp3")},
	{"name": "Stand Clear of the Closing Doors", "stream": preload(SOUND_DIR + "stand-clear-of-the-closing-doors-please.mp3")},
	{"name": "Gong", "stream": preload(SOUND_DIR + "shinese-gong.mp3")},
	{"name": "Running", "stream": preload(SOUND_DIR + "running.mp3")},
	{"name": "Rizz", "stream": preload(SOUND_DIR + "rizz-sound-effect.mp3")},
	{"name": "Ohhh Yeahhh", "stream": preload(SOUND_DIR + "ohhh_yeahhh.mp3")},
]

var _player := AudioStreamPlayer.new()


func _ready() -> void:
	add_child(_player)


## Returns `count` different random sound indexes.
func fetch_random_sounds(count: int) -> Array[int]:
	var pool: Array[int] = []
	for i in SOUNDS.size():
		pool.append(i)
	pool.shuffle()
	return pool.slice(0, min(count, SOUNDS.size()))


func get_sound_name(index: int) -> String:
	return SOUNDS[index]["name"]


func get_stream(index: int) -> AudioStream:
	return SOUNDS[index]["stream"]


## Plays a sound, cutting off whatever was playing before.
func play(index: int) -> void:
	var stream := get_stream(index)
	_player.stream = stream
	_player.play()
	await get_tree().create_timer(3.0).timeout
	if _player.stream == stream:
		_player.stop()

func stop() -> void:
	_player.stop()


## Use with `await` to wait until the current sound is done,
## e.g. when playing a story's sounds back in order.
func wait_until_finished() -> void:
	if _player.playing:
		await _player.finished
