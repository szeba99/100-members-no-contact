extends CharacterBody2D

@onready var indicator: Label = $Indicator

@export_multiline var dialogue: Array[String] = [
	"The TV is playing an anime about metal monsters fighting.", "How absurd."
]

@export var is_pickup: bool = false

func show_indicator():
	if indicator:
		indicator.show()

func hide_indicator():
	if indicator:
		indicator.hide()
