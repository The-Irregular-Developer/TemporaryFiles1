class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal enemy_damaged(hurt_box : HurtBox)
signal enemy_destroyed(hurt_box : HurtBox)

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine
@onready var hit_box : HitBox = $HitBox

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func SetDirection(_new_direction : Vector2) -> bool:	
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	# Determines if character walking left/right
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir : Vector2 = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.flip_h = true if cardinal_direction == Vector2.LEFT else false
	return true
	
func UpdateAnimation( state : String ) -> void:
	animation_player.play(state + "_" + AnimDirection()) # Sets the current animation of the character to be the one in parentheses. Using variables in parentheses makes it more dynamic to change state and direction.
	pass # If function is empty, keyword pass must be added to ensure no error is given.


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit(hurt_box)
	else:
		enemy_destroyed.emit(hurt_box)
