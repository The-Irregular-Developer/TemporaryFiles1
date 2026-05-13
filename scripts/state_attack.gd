class_name State_Attack extends State

var attacking : bool = false
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0

@onready var walk : State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = $"../../HurtBox"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func Enter() -> void:
	player.UpdateAnimation("attack")
	attacking = true
	animation_player.animation_finished.connect( EndAttack )
	await get_tree().create_timer(1).timeout
	hurt_box.monitoring = true
	if (player.cardinal_direction == Vector2.UP):
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(0, -20.0));
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(1.5707, Vector2(0, -80.0));
	elif(player.cardinal_direction == Vector2.DOWN):
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(0, -20.0));
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(1.5707, Vector2(0, 80.0));
	elif (player.cardinal_direction == Vector2.LEFT):
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(0, -20.0));
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(-42.0, -20.0));
	elif(player.cardinal_direction == Vector2.RIGHT):
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(0, -20.0));
		$"../../HurtBox/CollisionShape2D".transform = Transform2D(0, Vector2(42.0, -20.0));
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	hurt_box.monitoring = false
	pass

func Process(_delta : float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func EndAttack( _newAnimName : String) -> void:
	attacking = false

# What happens during the _physics_process update in this state?
func Physics(float) -> State:
	return null
	
# What happens with input events in this state?
func HandleInput(InputEvent) -> State:
	return null
