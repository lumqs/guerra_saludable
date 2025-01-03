extends CanvasLayer

@onready var slot_1: Sprite2D = $Barra_vida/slot_1
@onready var slot_2: Sprite2D = $Barra_vida/slot_2
@onready var slot_3: Sprite2D = $Barra_vida/slot_3
@onready var slot_4: Sprite2D = $Barra_vida/slot_4
@onready var slot_5: Sprite2D = $Barra_vida/slot_5
var vidas=[]


func _ready() -> void:
	vidas=[slot_1,slot_2,slot_3,slot_4,slot_5]

func _process(delta: float) -> void:
	pass


func controlar_vida(vidas):
	var parametro= get_parent().vida
	for i in range(5):
		if i > (parametro-1):
			vidas[i].visible=false
		else: vidas[i].visible= true

#----se emite cuando pierdo vida----
func _on_character_body_2d_perder_vida() -> void:
	controlar_vida(vidas)#llama a la funcion que testea
