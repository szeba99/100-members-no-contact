extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = randf_range(-PI, PI)
	animation_finished.connect(expired)

func expired():
	queue_free()
