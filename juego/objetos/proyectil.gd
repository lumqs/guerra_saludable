extends RigidBody2D

@onready var animm: AnimatedSprite2D = $AnimatedSprite2D
var direccion
var punto_inicio: Vector2
var max_distancia= 1000

func _ready() -> void:
	animm.play("default")
	punto_inicio = position

#si la bala supera los 1000 de distancia lo borra
func _process(delta):
	#abs es la distancia que tiene algo del 0
	if abs(position.x - punto_inicio.x) > max_distancia:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	animm.play("colisiona")
	queue_free()
