class_name TimeSystem extends Node

signal updated

@export var date_time : DateTime
@export var ticks_pr_second : int = 6 # How many ticks (in game seconds) occur in one second (real time seconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	date_time.increase_by_sec(delta * ticks_pr_second)
	updated.emit(date_time)


func _on_updated() -> void:
	pass # Replace with function body.
