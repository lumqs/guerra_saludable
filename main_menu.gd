extends Node


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Clic izquierdo en la posición:", event.position)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://juego/UI/elegir_personaje.tscn")
