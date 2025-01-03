extends Area2D

#--Lista de Alimentos--
enum Alimentos{
	MANZANA, CARNE, AGUA,ENSALADA}

#---Mapeo de listas--------
var nombre_alimentos= {
	Alimentos.MANZANA:"manzana",
	Alimentos.CARNE:"carne",
	Alimentos.AGUA:"agua"
}

@export var tipo_alimento : Alimentos #menu desplegable
@onready var recoger: Label = $recoger #cartel de "R"
@onready var comida_db = $DataBaseAlimentos
var propiedades={}


func _ready() -> void:
	recoger.visible= false#cartel de "R" recoger
	var nombre_alimento= nombre_alimentos[tipo_alimento]
	$skin.play(nombre_alimento)
	
	#---obtenemos los valores del alimento---
	if nombre_alimento in comida_db.propiedades_alimentos:
		propiedades = comida_db.propiedades_alimentos[nombre_alimento]


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Personaje"):
		recoger.visible = true

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Personaje"):
		recoger.visible = false
