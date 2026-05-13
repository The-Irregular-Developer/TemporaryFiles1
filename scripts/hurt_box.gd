class_name HurtBox extends Area2D # Hurtbox causes damage to hitboxes.

@export var damage : int = 1

func _ready():
	area_entered.connect(AreaEntered)
	pass

func _process(delta):
	pass

func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
	pass
