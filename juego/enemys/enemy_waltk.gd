extends CharacterBody2D

var vida:=60
var speed := 240
var jump := 400  # Fuerza del salto
const GRAVITY := 18
var can_jump := true


enum Enemigos{BURGUER,PAPA_FRITA,HUEVO_FRITO,MANAOS,ALFAJOR,HELADO,HOT_DOG}

#-----------mapa-del-enum-----------
var nombre_enemigos={
	Enemigos.BURGUER:"burguer",
	Enemigos.PAPA_FRITA:"papa_frita",
	Enemigos.HUEVO_FRITO:"huevo_frito",
	Enemigos.MANAOS:"manaos",
	Enemigos.ALFAJOR:"alfajor",
	Enemigos.HELADO:"helado",
	Enemigos.HOT_DOG:"hot_dog"}

@onready var heath_bar: TextureProgressBar = $heath_bar
@export var tipo_enemigo: Enemigos
@onready var skin_enemy: AnimatedSprite2D = $skin_enemy
@onready var saltar: RayCast2D = $saltar
@onready var pared: RayCast2D = $pared
@onready var enemy_db: Node2D = $DataBaseEnemy
var propiedades={}

func _ready() -> void:
	heath_bar.value=60
	var nombre_enemigo= nombre_enemigos[tipo_enemigo]
	#obtengo las propiedades del enemigo
	propiedades=enemy_db.propiedades_enemys[nombre_enemigo]
	#--------elegir_skin-------
	skin_enemy.play(nombre_enemigo)

func _physics_process(delta: float) -> void:
	velocity.x = speed
	#----opcion de flip------
	if velocity.x<0:
		skin_enemy.flip_h=true
	else: skin_enemy.flip_h=false
	
	if not is_on_floor():
		velocity.y += GRAVITY
	if is_on_floor():
		can_jump = true
	
	#----------SALTAR----------
	if pared.is_colliding() and not saltar.is_colliding():
		if can_jump:#permite un salto
			velocity.y = -jump
			can_jump = false
	#-------DARSE LA VUELTA--------
	elif pared.is_colliding() and saltar.is_colliding():
		speed*=-1
		pared.target_position.x*=-1
		saltar.target_position.x*=-1
	
	if heath_bar.value<=0:
		$".".queue_free() #eliminar enemigo
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	#---RECIBE UN DISPARO---
	if area.is_in_group("municion"):
		heath_bar.value-=5
	if area.is_in_group("espada"):
		heath_bar.value-=20
