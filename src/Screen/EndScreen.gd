extends Control

# Canviar el valor del label
onready var label: Label = get_node("Label")

func _ready() -> void:
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
