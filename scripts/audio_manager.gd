extends Node

@onready var music_player = AudioStreamPlayer.new()
@onready var click_player = AudioStreamPlayer.new()
@onready var success_player = AudioStreamPlayer.new()
@onready var fail_player = AudioStreamPlayer.new()
@onready var unlock_player = AudioStreamPlayer.new()
@onready var sparkle_player = AudioStreamPlayer.new()
@onready var star_player = AudioStreamPlayer.new()
@onready var mix_player = AudioStreamPlayer.new()
var music_stream : AudioStream = preload("res://assets/audio/thinking_scientifically.mp3")
var click_sound : AudioStream = preload("res://assets/audio/mixkit-modern-technology-click.wav")
var success_sound : AudioStream = preload("res://assets/audio/mixkit-game-success-alert.wav")
var fail_sound : AudioStream = preload("res://assets/audio/mixkit-tech-break-fail.wav")
var unlock_sound : AudioStream = preload("res://assets/audio/mixkit-unlock-game-notification.wav")
var sparkle_sound : AudioStream = preload("res://assets/audio/mixkit-fairy-arcade-sparkle.wav")
var star_sound : AudioStream = preload("res://assets/audio/mixkit-achievement-bell.wav")
var mix_sound : AudioStream = preload("res://assets/audio/mixkit-musical-reveal.wav")
var is_playing = false

func _ready():
	# set up music player
	add_child(music_player)
	music_player.stream = music_stream
	music_player.autoplay = true

	# if the music isn't playing already, start it
	if not is_playing:
		music_player.play()
		is_playing = true

	# set up click player
	add_child(click_player)
	click_player.stream = click_sound

	# set up success player
	add_child(success_player)
	success_player.stream = success_sound

	# set up fail player
	add_child(fail_player)
	fail_player.stream = fail_sound

	# set up unlock player
	add_child(unlock_player)
	unlock_player.stream = unlock_sound

	# set up sparkle player
	add_child(sparkle_player)
	sparkle_player.stream = sparkle_sound

	# set up star player
	add_child(star_player)
	star_player.stream = star_sound

	# set up mix player
	add_child(mix_player)
	mix_player.stream = mix_sound

func set_music_volume(linear: float):
	#music_player.volume_db = clamp(linear, -80, 0)
	music_player.volume_db = linear_to_db(linear)

func set_sfx_volume(linear: float):
	for audio_player in [click_player, success_player, fail_player, unlock_player,
	sparkle_player, star_player, mix_player]:
		audio_player.volume_db = linear_to_db(linear)

func button_click():
	click_player.play()

func success():
	success_player.play()

func fail():
	fail_player.play()

func unlock():
	unlock_player.play()

func sparkle():
	sparkle_player.play()

func star():
	star_player.play()

func mix():
	mix_player.play()
