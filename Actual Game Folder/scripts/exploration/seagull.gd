extends Node2D


@onready var body: CharacterBody2D = $CharacterBody2D
@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D


var direction = 0 # 0-rt 1-up 2-lt 3-dn
var direction_timer = 0.0
var step_timer = 0.0


func _physics_process(delta: float) -> void:
	if body.is_talking:
		return
	direction_timer -= delta
	if direction_timer <= 0.0:
		direction_timer = randf_range(0.3, 2.8)
		direction = randi() % 4
		if direction == 0:
			sprite.flip_h = true
		elif direction == 2:
			sprite.flip_h = false
	
	step_timer -= delta
	if step_timer <= 0.0:
		step_timer = randf_range(0.3, 0.8) + float(randi() % 10 == 0) * randf_range(1.0, 3.0)
		var motion := Vector2()
		var step_size = 3.0
		match direction:
			0:
				motion = Vector2(step_size, 0.0)
			1:
				motion = Vector2(0.0, -step_size)
			2:
				motion = Vector2(-step_size, 0.0)
			3:
				motion = Vector2(0.0, step_size)
		if !body.test_move(body.global_transform, motion):
			body.move_and_collide(motion)
