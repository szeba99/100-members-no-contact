extends CharacterBody2D

# TODO:
# Add collision shape for the player
# Also I added that texture of player as "TextureRect" which is a "Control" node
# I'm not sure, if that was supposed to be a "Control" node

# Can be part of a power up later
# What's the mechanic like? I'm not sure about the core mechanic right now
# Is player going to control the beyblade? Against who? It could be speedrun type game.
var default_velocity: float = 200;

func _physics_process(delta: float) -> void:
	rotate(1.0)
	
	var current_velocity = Vector2(0, 0);

	if Input.is_action_pressed("left"):
		current_velocity[0] -= default_velocity;

	if Input.is_action_pressed("right"):
		current_velocity[0] += default_velocity;

	if Input.is_action_pressed("up"):
		current_velocity[1] -= default_velocity;

	if Input.is_action_pressed("down"):
		current_velocity[1] += default_velocity;

	velocity = current_velocity;
	move_and_slide();

	pass
