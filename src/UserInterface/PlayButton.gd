tool
extends Button

export(String, FILE) var next_scene_path: = ""

func _on_PlayButton_button_up() -> void:
	PlayerData.reset()
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path no té nivell per carrega" if next_scene_path == "" else ""
