extends CharacterBody2D

var vida=60
var speed = 150
var detection_area = null
var player = null

var empujado= false
var empuje = Vector2.ZERO
var empuje_fuerza = 50  # Valor ajustable, inicializa a lo que desees
var empuje_deceleracion = 0.5  # Cuanto más alto, más rápido se detiene

@onready var heath_bar: TextureProgressBar = $Heath_Bar

var propiedades = {"vida":5,"vitamina":0,"proteina":0,"hidratacion":0,"fibra":0,"azucar":20}


func _ready():	
	heath_bar.value=60
	$AnimatedSprite2D.play("default")
	detection_area = $area_grande
	detection_area.body_entered.connect(Callable(self, "_on_detection_area_entered"))
	detection_area.body_exited.connect(Callable(self, "_on_detection_area_exited"))


func _physics_process(delta: float) -> void:
	if empujado:
		# Desacelerar gradualmente el empuje
		empuje = empuje.move_toward(Vector2.ZERO, empuje_deceleracion * delta)
		velocity += empuje
	else:
		if player:
			var direction = (player.position - position).normalized()
			velocity = direction * speed
	if heath_bar.value<=0:
		self.queue_free()
	
	move_and_slide()

func _on_detection_area_entered(body):
	if body.is_in_group("Personaje"):
		player = body 

func _on_detection_area_exited(body):
	if body.is_in_group("Personaje"):
		player = null 

func _on_recibir_daño_area_entered(area: Area2D) -> void:
	if area.is_in_group("espada"):
		heath_bar.value-=20
		# Aplicar empuje inicial al ser golpeado
		var direction = (position - area.global_position).normalized()  # Empuja en la dirección opuesta
		empuje = direction * empuje_fuerza
		empujado= true
		$Timer.start()
		
	if area.is_in_group("municion"):
		heath_bar.value-=5

func _on_timer_timeout() -> void:
	empujado= false
