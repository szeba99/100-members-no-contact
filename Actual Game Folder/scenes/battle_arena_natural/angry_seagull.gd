extends Sprite2D

var direction: Vector2 = Vector2(1.0, 0.0)
var velocity = 350.0
var damage = 9.0


var altitude = 1.0
var descent_rate = 0.11
var ascent_rate = 0.14
var attack_time

enum mode {
	descent,
	attack,
	ascent
}
var current_mode := mode.descent
var go_left := false


static var max_angle_deviation = 0.2


func _ready() -> void:
	attack_time = randf_range(0.75, 1.25)


func descend():
	current_mode = mode.descent
	if go_left:
		flip_v = true
		rotation = 0.75 * PI + randf_range(-max_angle_deviation, max_angle_deviation)
	else:
		rotation = 0.25 * PI + randf_range(-max_angle_deviation, max_angle_deviation)
		
	direction = Vector2(1.0, 0.0).rotated(rotation)


func ascend():
	current_mode = mode.ascent
	if go_left:
		rotation = 1.25 * PI + randf_range(-max_angle_deviation, max_angle_deviation)
	else:
		rotation = -0.25 * PI + randf_range(-max_angle_deviation, max_angle_deviation)
	direction = Vector2(1.0, 0.0).rotated(rotation)


func attack():
	current_mode = mode.attack
	if go_left:
		rotation = PI + randf_range(-max_angle_deviation, max_angle_deviation)
	else:
		rotation = randf_range(-max_angle_deviation, max_angle_deviation)
	direction = Vector2(1.0, 0.0).rotated(rotation)


func _physics_process(delta: float) -> void:

	match current_mode:
		mode.descent:
			position += direction * velocity * delta
			altitude -= descent_rate
			modulate.a = clamp(1.0 - altitude, 0.0, 1.0)
			if altitude <= 0.0:
				attack()

		mode.attack:
			bullet_motion(delta)
			attack_time -= delta
			if attack_time <= 0.0:
				ascend()

		mode.ascent:
			position += direction * velocity * delta
			altitude += ascent_rate
			modulate.a = clamp(1.0 - altitude, 0.0, 1.0)
			if altitude >= 1.0:
				queue_free()


func bullet_motion(delta: float):

	# Query space for collisions
	var dss := get_world_2d().direct_space_state
	var pms := PhysicsRayQueryParameters2D.new()
	pms.from = position
	pms.to = position + direction * velocity * delta
	pms.hit_from_inside = true
	var res := dss.intersect_ray(pms)

	# No collisions, advance
	if res.is_empty():
		position = pms.to
		return

	# Collisions
	var poof = preload("res://Actual Game Folder/scenes/battle_arena_natural/poof.tscn").instantiate()
	get_parent().add_child(poof)
	poof.position = position
	queue_free() # This for sure unless you want piercing, bouncing, forking...

	var collider = res["collider"]

	# If it's a player
	if collider.is_in_group("player"):
		collider.take_damage(damage)

	# If it's an enemy
	if collider.is_in_group("horde_enemy"):
		collider.take_damage(damage)
