extends Area2D

var posicion= Vector2(37,4)
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var anim: AnimatedSprite2D = $"../AnimatedSprite2D"

func _ready() -> void:
	collision.disabled= true
	collision.position=posicion

func _process(delta: float) -> void:
	if anim.flip_h==true:
		collision.position=-posicion
	else: collision.position=posicion
	
	if Input.is_action_just_pressed("ataque_espada"):
		collision.disabled= false


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation=="attack":
		collision.disabled=true
