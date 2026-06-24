class_name Item
extends Resource

enum Type {START_OF_BATTLE, END_OF_BATTLE, CONSUMABLE, EVENT }

@export var item_name : String
@export var id: String
@export var type : Type
@export var icon: Texture
@export_multiline var tooltip: String

func initalize_item(_owner: ItemUI) -> void:
	pass


func activate_item(_owner: ItemUI) -> void:
	pass


func deactivate_item(_owner: ItemUI) -> void:
	pass


func get_tooltip() -> String:
	return tooltip
