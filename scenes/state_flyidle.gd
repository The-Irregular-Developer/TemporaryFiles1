class_name State_FlyIdle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"
@onready var flywalk : State = $"../FlyWalk"
@onready var flyidle : State = $"../FlyIdle"

func Enter() -> void:
	player.UpdateAnimation("fly")
	
	pass

func Process(float) -> State:
	if player.direction != Vector2.ZERO:
		return flywalk
	player.velocity = Vector2.ZERO
	return null

func Exit() -> void:
	pass
	
func HandleInput(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
