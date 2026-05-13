class_name State_Walk extends State

# Export variable means it will display in the inspector, allowing us to manipulate the variable without entering the script.
@export var move_speed : float = 150.0

@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"
@onready var flyidle : State = $"../FlyIdle"

func Enter() -> void:
	if PlayerManager.currently_flying == false:
		player.UpdateAnimation("walk")
	else:
		player.UpdateAnimation("fly")
	pass

func Process(float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection() and PlayerManager.currently_flying == false:
		player.UpdateAnimation("walk")
	elif PlayerManager.currently_flying == true:
		player.UpdateAnimation("fly")
	
	if PlayerManager.currently_flying == true:
		move_speed = 300
		player.set_collision_mask_value(5, false)
		player.hit_box.monitoring = false
		player.hit_box.monitorable = false
		player.z_index = 5
	elif PlayerManager.currently_flying == false:
		move_speed = 150
		player.set_collision_mask_value(5, true)
		player.hit_box.monitoring = true
		player.hit_box.monitorable = true
		player.z_index = 0
	
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
