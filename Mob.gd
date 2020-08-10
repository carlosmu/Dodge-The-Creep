extends RigidBody2D

# Variables miembro
export var min_speed = 150 # Minimum speed range
export var max_speed = 250 # Maximum speed range

# Called when the node enters the scene tree for the first time.
func _ready():
	# Obtenemos los nombres de las animaciones (devuelve un array)
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# randi() € n selecciona un entero al azar entre 0 y n-1
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
