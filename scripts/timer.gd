extends Node2D

func _ready():
	$UpdateTimer.start()

func _on_update_timer_timeout():
	var time_elapsed: int = floor((Time.get_ticks_msec() - GameManager.current_level_data.level_start_time) / 1000.0)
	time_elapsed = min(time_elapsed, 5940) # set max external timer value
	var minutes = time_elapsed / 60
	var seconds = time_elapsed % 60
	$TimerLabel.text = "%d:%02d" % [minutes, seconds]
