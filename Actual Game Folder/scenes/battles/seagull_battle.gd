extends Node



enum phase {
	clear,
	delay,
	wave_from_left,
	wave_from_right,
	horde,
	boss,
	win
}

var battle_plan = [
	phase.delay,
	phase.wave_from_right,
	phase.clear,
	phase.wave_from_left,
	phase.clear,
	phase.horde,
	phase.clear,
	phase.wave_from_left,
	phase.wave_from_right,
	phase.horde,
	phase.boss,
	phase.clear,
	phase.win
]

var current_phase = 0

@onready var player = $Player

var timer = 0.0
var spawntimer = 0.0


func _ready() -> void:
	SceneManager.player_beyblade = $Player
	SceneManager.bullet_container = $bullet_container
	SceneManager.debris_container = $debris_container


func advance():
	current_phase += 1

	match battle_plan[current_phase]:
		phase.delay:
			timer = 3.0
		phase.wave_from_left, phase.wave_from_right:
			timer = 6.0
			spawntimer = 0.0
		phase.horde:
			timer = 6.0
			spawntimer = 0.0
		phase.boss:
			spawntimer = 3.0
		phase.win:
			SceneManager.end_battle()



func position_in_area(p: Vector2):
	for poly in $game_area.get_children():
		if Geometry2D.is_point_in_polygon(p, poly.polygon):
			return true
	return false



func _process(delta: float) -> void:
	
	timer -= delta
	spawntimer -= delta

	match battle_plan[current_phase]:
		phase.clear:
			if $enemy_container.get_child_count() == 0:
				advance()
		phase.delay:
			if timer <= 0.0:
				advance()
		phase.wave_from_left:
			if spawntimer <= 0.0:
				spawntimer = randf_range(0.125, 0.35)
				var sg = preload("res://Actual Game Folder/scenes/battle_arena_natural/angry_seagull.tscn").instantiate()
				sg.global_position = player.global_position + Vector2(randf_range(-300, -200), randf_range(-200, 150))
				sg.go_left = false
				sg.descend()
				$enemy_container.add_child(sg)
			if timer <= 0.0:
				advance()
		phase.wave_from_right:
			if spawntimer <= 0.0:
				spawntimer = randf_range(0.125, 0.35)
				var sg = preload("res://Actual Game Folder/scenes/battle_arena_natural/angry_seagull.tscn").instantiate()
				sg.global_position = player.global_position + Vector2(randf_range(200, 300), randf_range(-200, 150))
				sg.go_left = true
				sg.descend()
				$enemy_container.add_child(sg)
			if timer <= 0.0:
				advance()
		phase.horde:
			if spawntimer <= 0.0:
				spawntimer = randf_range(0.125, 0.25)
				var pos := Vector2(-100000, -100000)
				while !position_in_area(pos):
					pos = player.global_position + Vector2(randf_range(300, 400), 0.0).rotated(randf_range(-PI, PI))
				var sg = preload("res://Actual Game Folder/scenes/components/exploration/horde_seagull.tscn").instantiate()
				sg.global_position = pos
				$enemy_container.add_child(sg)
			if timer <= 0.0:
				advance()
		phase.boss:
			var pos := Vector2(-100000, -100000)
			while !position_in_area(pos):
				pos = player.global_position + Vector2(randf_range(300, 400), 0.0).rotated(randf_range(-PI, PI))
			var sg = preload("res://Actual Game Folder/scenes/components/exploration/seagull_boss.tscn").instantiate()
			sg.global_position = pos
			$enemy_container.add_child(sg)
			advance()
		



	
