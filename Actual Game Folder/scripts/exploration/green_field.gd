extends Node2D
@onready var area_sign: TextureRect = $PlayerEx/CharacterBody2D/AreaSign


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var signfall = create_tween()
	area_sign.visible = true # Replace with function body.
	signfall.tween_property(area_sign, "position", Vector2(56.667, -86.667), 1.0)
	await signfall.finished
	await get_tree().create_timer(4.0).timeout
	var signup = create_tween()
	signup.tween_property(area_sign, "position", Vector2(56.667, -155.757), 1.0)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
