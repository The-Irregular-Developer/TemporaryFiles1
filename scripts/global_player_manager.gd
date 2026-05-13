extends Node

var player : Player
var currently_flying: bool = false
var timer_start : bool = false
var cooldown_timer : bool = false

func _process(delta: float) -> void:	
	if (currently_flying == true and timer_start == false and cooldown_timer == false):
		timer_start = true
		await get_tree().create_timer(5).timeout
		timer_start = false
		currently_flying = false
		cooldown_timer = true
		
	pass
