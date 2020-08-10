extends Area2D
signal hit

# Declarar las variables miembro aquí.
export var speed = 400 # Cómo de rápido se mueve el player px por segundo
var screen_size # Tamaño de la ventana de juego


#  Llamado cuando el nodo entra en la jerarquíe de la escena por primera vez
# Sería quizás el equivalente al awake de Unity
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Se llama en cada frame, sería quizás el equivalente al update de Unity.
# Delta es el tiempo transcurrido desde el frame anterior.
func _process(delta):
	var velocity = Vector2() # El vector de movimiento del player.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		# Normalizamos p/evitar que en diagonal no sea más rápido por la sumatoria.
		velocity = velocity.normalized() * speed 
		# $ es una forma abrebiada de "get_node()", parecido al GetComponent
		# Ej: get_node("AnimatedStrite").play()
		$AnimatedSprite.play()
	else: 
		$AnimatedSprite.stop()
	# Clamp para que no se salga de la pantalla
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	# Espejar la animación para izquierda y abajo
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0



func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
