extends CharacterBody2D

var inmunidad= 0.5 #segundo INCOMPLETO

var vida = 5
var speed := 240
var direccion := 0.0
var jump := 500
const  GRAVITY := 18
var contador_saltos = 0
var animacion_especial= false
var alimento_en_area: Area2D= null
var daño
var inventario=[null,null,null]#incompleto
var slot_seleccionado: int= 0 #posicion del inventario
var proyectil= preload("res://juego/objetos/proyectil.tscn")
var direccion_proyectil= 1

@onready var barra_vida: CanvasLayer = $barra_vida
@onready var anim := $AnimatedSprite2D
@onready var sprite:= $Sprite2D

signal perder_vida #creo una señal

func _ready():
	anim.animation_finished.connect(_on_animated_sprite_2d_animation_finished)

func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	#---Evitar proyectiles tiezos------
	if direccion!=0:
		direccion_proyectil = direccion 
	
	#------------FLIP ANIMACIONES-----------
	if velocity.x<0:
		anim.flip_h=true
	elif velocity.x>0:
		anim.flip_h=false
	
	
	if not is_on_floor():
		velocity.y += GRAVITY
	if is_on_floor():
		contador_saltos = 0
		#------------CORRER------------
		if Input.is_action_pressed("correr"):
			speed= 480
	
	#-----------------SALTAR---------------------
	if Input.is_action_just_pressed("ui_accept") and contador_saltos<2:
		velocity.y=0
		velocity.y-= jump
		contador_saltos += 1
	
	#-------Reproducir animaciones comunes-------
	if not animacion_especial: #animaciones que interrumpen
		decidir_animacion()
	
	move_and_slide()



func _input(event: InputEvent) -> void:
#-------Seleccionar espacio del inventario---------
	if event.is_action_pressed("selec. slot #1"):
		slot_seleccionado=0
	elif event.is_action_pressed("selec. slot #2"):
		slot_seleccionado=1
	elif event.is_action_pressed("selec. slot #3"):
		slot_seleccionado=2
		
	#-----------------ATAQUE ESPADA--------------
	if Input.is_action_just_pressed("ataque_espada"):
		animacion_especial=true
		anim.play("attack")
		
	#-----------------ATAQUE DISPARO--------------
	if Input.is_action_just_pressed("shoot"): #si Presiono "Q"
		animacion_especial=true     
		anim.play("shoot")          
		var new_proyectil= proyectil.instantiate() 
		new_proyectil.position = position    #aparece en la posicion del jugador 
		if direccion_proyectil<0:
			new_proyectil.position -= Vector2(100,0)  #una especie de "flip"
		new_proyectil.linear_velocity = Vector2(800,0) * direccion_proyectil
		self.get_parent().add_child(new_proyectil)
		
	#-------------CONSUMIR ALIMENTO----------------
	if Input.is_action_just_pressed("consumir") and alimento_en_area :
		vida += alimento_en_area.propiedades["vida"]
		alimento_en_area.queue_free()
		alimento_en_area=null
	
	if Input.is_action_just_pressed("fireball"):
		pass


func decidir_animacion():
	#---------eje x -----------
	if is_on_floor():
		if velocity.x== 0:
			anim.play("idle")
		else: anim.play("walk")
	#---------eje Y------------
	if velocity.y<0:
		anim.play("jump")
	elif velocity.y >0:
		anim.play("fall")



#-----------------TELETRANSPORTAR----------------
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.get_class()=="StaticBody2D"):
		get_tree().change_scene_to_file("res://juego/escenarios/"+body.name+".tscn")
	#------si colisiono con enemigo-------
	if body.is_in_group("enemigo"):
		pass#INCOMPLETO

#------------DETENER ANIMACIONES ESPCEIALES--------
func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation=="attack":
		animacion_especial= false
	if anim.animation=="shoot":
		animacion_especial=false


func _on_area_2d_area_entered(area: Area2D) -> void:
	#--------DETECTAR ALIMENTOS------------
	if area.is_in_group("alimento"):
		alimento_en_area= area
		
	#-------DETECTAR ENEMIGO--------------
	elif area.is_in_group("enemigo"):
		daño= area.get_parent().propiedades
		vida-= daño["vida"]
		emit_signal("perder_vida")
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	#-----si el jugador se va del area, no hay alimento
	if area.is_in_group("alimento"):
		alimento_en_area= null
	elif area.is_in_group("enemigo"):
		daño= null
