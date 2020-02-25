tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene


func _on_pertal2D_body_entered(body: Node) -> void:
	teleport()


func _get_configuration_warning() -> String:
	return "La pripietat de la següent escena esta vuida!" if not next_scene else ""

func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)

