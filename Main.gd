extends Node

export (PackedScene) var Mob
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# new_game() # Solo para probar...


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hit():
	pass # Replace with function body.


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	# Elegir una ubicación aleatoria en Path2D
	$MobPath/MobSpawnLocation.offset = randi()
	# Crear una instancia Mob y agregarla a la escena
	var mob = Mob.instance()
	add_child(mob)
	# Configurar la dirección del mob perpendicular a la ruta de dirección
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Configurar la posicion del mob a una ubicación aleatoria
	mob.position = $MobPath/MobSpawnLocation.position
	# Agregar algunas aleatoriedades a la dirección
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Configurar la velocidad (speed & direction)
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
