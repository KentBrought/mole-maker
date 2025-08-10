extends Control

func _ready():
	$MusicHSlider.value = db_to_linear(AudioManager.music_player.volume_db)
	$MusicHSlider.connect("value_changed", AudioManager.set_music_volume)
	$SFXHSlider2.value = db_to_linear(AudioManager.click_player.volume_db)
	$SFXHSlider2.connect("value_changed", AudioManager.set_sfx_volume)
