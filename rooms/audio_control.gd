extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	_change_music("ice_caves")
var music_records = {}
var last_song_name = null
var music_name_playing = null
# loads music, save the second the previous music stopped, 
# and attempts to put the current music at the second it
#stopped if it was previously played
func _change_music(music_name, file_type = "mp3"):
	
	var music = null
	var time = 0
	if music_records.has(music_name):
		music = music_records[music_name].music
		time = music_records[music_name].time
	else:
		music = load("res://sound/" + music_name + "." + file_type)
		music_records[music_name] = {}
		music_records[music_name].music = music
		music_records[music_name].time = 0
	
	
	stream = music
	play(time)
	
	if music_name_playing:
		last_song_name = music_name_playing
		music_records[last_song_name].time = get_playback_position()
	
	music_name_playing = music_name
	
	
func _return_to_last_song():
	_change_music(last_song_name)
