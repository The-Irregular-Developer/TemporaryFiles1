extends CanvasLayer

@onready var progressBar : TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func updateBar(currentHealth : float, maxHealth : float):
	progressBar.value = (currentHealth / maxHealth) * 100
	print(progressBar.value)
	pass
