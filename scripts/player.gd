class_name Player extends CharacterBody2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : StateMachine = $"State Machine"
@onready var hit_box: HitBox = $HitBox
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer

var cardinal_direction : Vector2 = Vector2.DOWN # The current cardinal direction (Up, Down, Left or Right) that the player is facing. Initially, it is down.
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP] # The four cardinal directions that the player can face.
var direction : Vector2 = Vector2.ZERO # Holds the current precise direction the player is facing.

signal DirectionChanged(new_direction : Vector2) # Sends out signals when the direction has changed
signal player_damaged(hurt_box : HurtBox)

var invulnerable : bool = false
var hp : int = 10
var max_hp : int = 10

func _ready() -> void:
	state_machine.Initialize(self)
	PlayerManager.player = self
	update_hp(99)
	hit_box.Damaged.connect(_take_damage)
	pass

func _process(delta : float) -> void:
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	pass

func UpdateAnimation(state: String) -> void: # Updates the current animation being played
	animation_player.play(state + "_" + AnimDirection())
	pass

func SetDirection() -> bool: # Determines and sets the current direction of the player
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size())) # Based on the player's direction, determines the correct ID to which direction the player is at
	var new_dir : Vector2 = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false # Failed to change direction
	
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	return true # Successfully changed direction

func AnimDirection() -> String: # Sets the current animation direction
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	else:
		return "right"

func _physics_process(delta: float) -> void:
	move_and_slide()

func _take_damage(hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp(-hurt_box.damage)
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_hp(99)
	pass

func update_hp(delta : int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.updateBar(hp, max_hp)
	pass

func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass
	
