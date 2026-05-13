class_name State_FlyWalk extends State

# Export variable means it will display in the inspector, allowing us to manipulate the variable without entering the script.
@export var move_speed : float = 250.0

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"

func Enter() -> void:
	player.UpdateAnimation("flywalk")
	pass

func Process(float) -> State:	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("flywalk")
	
	return null

func Exit() -> void:
	pass

func HandleInput(_event : InputEvent) -> State:
	if _event.is_action_released("fly") and player.direction != Vector2.ZERO:
		return walk
	elif _event.is_action_released("fly") and player.direction == Vector2.ZERO:
		return idle
	elif _event.is_action_pressed("fly") and player.direction == Vector2.ZERO:
		return
	return null
