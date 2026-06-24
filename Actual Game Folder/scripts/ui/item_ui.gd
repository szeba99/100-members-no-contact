class_name ItemUI
extends Control

@export var item: Item : set = set_item

@onready var icon : TextureRect = $Icon


func set_item(new_item : Item) -> void:
	if not is_node_ready():
		await ready
	item = new_item
	icon.texture = item.icon


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("Item tooltip")

func _ready() -> void:
	item = preload("res://Actual Game Folder/scenes/components/items/example_item_1.tres")
