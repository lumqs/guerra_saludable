extends CanvasLayer

@onready var contorno: Sprite2D = $contorno

var posiciones_slot=[Vector2(155.714,-8.571),Vector2(267.143,-8.571),Vector2(381.429,-8.571)]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("selec. slot #1"):
		contorno.position=posiciones_slot[0]
	if event.is_action_pressed("selec. slot #2"):
		contorno.position=posiciones_slot[1]
	if event.is_action_pressed("selec. slot #3"):
		contorno.position=posiciones_slot[2]
