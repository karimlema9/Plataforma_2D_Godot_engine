extends Node

signal score_updated
signal player_died

# actualitzem el valor cada vegada que agafem una moneda
var score: = 0 setget set_score
var deaths: = 0 setget set_deaths


func reset() -> void:
	self.score = 0
	self.deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")

func set_deaths(value: int) -> void:
	score = value
	emit_signal("player_died")
