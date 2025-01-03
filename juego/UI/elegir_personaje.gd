extends Node


	
func _on_empezar_juego_pressed() -> void:
	get_tree().change_scene_to_file("res://juego/escenarios/escenario_1.tscn")
