class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"
@onready var flyidle : State = $"../FlyIdle"

func Enter() -> void:
	if PlayerManager.currently_flying == false:
		player.UpdateAnimation("idle")
	else:
		player.UpdateAnimation("fly")
	pass

func Process(float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	if PlayerManager.currently_flying == false:
		player.UpdateAnimation("idle")
	else:
		player.UpdateAnimation("fly")
	return null

func Exit() -> void:
	pass
	
func HandleInput(_event : InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		if PlayerManager.currently_flying == false:
			return attack
		elif PlayerManager.currently_flying == true:
			return null
	elif _event.is_action_pressed("fly"):
		if PlayerManager.timer_start == false:
			PlayerManager.currently_flying = !PlayerManager.currently_flying
		print(PlayerManager.currently_flying)
		return null
	return null
