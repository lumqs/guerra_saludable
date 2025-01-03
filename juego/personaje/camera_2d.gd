extends Camera2D
func _ready():
	top_level = true #es hija del nodo JUGADOR

func _process(delta):#decirle manualmente que NOS SIGA LA CAMARA
	global_position.x = get_parent().global_position.x
	#get_parents() es obtener al padre "JUGADOR"
	
	#global_position.y= 200
	global_position.y = get_parent().global_position.y
