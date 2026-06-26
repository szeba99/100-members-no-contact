extends CharacterBody2D

@onready var indicator: Label = $Indicator

@export_multiline var dialogue: Array[String] = [
	"We are not communicating so well", "-Cube512"
]

@export var is_pickup: bool = false

func show_indicator():
	if indicator:
		indicator.show()

func hide_indicator():
	if indicator:
		indicator.hide()
