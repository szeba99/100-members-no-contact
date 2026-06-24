class_name ItemControl
extends Control

const ITEMS_PER_PAGE := 7
const TWEEN_SCROLL_DURATION := 0.2

@onready var items: HBoxContainer = $Items
@onready var page_width = self.custom_minimum_size.x

var num_of_items := 0
var current_page := 1
var max_page := 0
var tween: Tween

func _ready() -> void:
	items.child_order_changed.connect(items_child_order_changed)
	items_child_order_changed()


func _process(delta: float) -> void:
	if max_page < 2:
		%"left button".modulate.a = 0
		%"right button".modulate.a = 0
	else: 
		%"left button".modulate.a = 255
		%"right button".modulate.a = 255


func _on_left_button_pressed() -> void:
	if current_page > 1:
		current_page -= 1
		update()
		_tween_to(items.position.x + page_width)
		print ("page: ",current_page)


func _on_right_button_pressed() -> void:
	if current_page < max_page:
		current_page += 1
		update()
		_tween_to(items.position.x - page_width)
		print("page: ",current_page)


#updates the display when a new item is added or removed
func items_child_order_changed() -> void:
	update()


func update() -> void:
	num_of_items = items.get_child_count()
	max_page = ceil(num_of_items / float(ITEMS_PER_PAGE))


# stops conflicting tweens
func _tween_to(x_pos: float) -> void:
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(items, "position:x", x_pos, TWEEN_SCROLL_DURATION)
