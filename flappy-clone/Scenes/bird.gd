extends CharacterBody2D

signal died

@export var gravity: float = 900.0
@export var jump_impulse: float = -300.0

var is_live: bool = true


func _physics_process(delta: float) -> void:
	if not is_live:
		return

	# Aplica gravidade
	velocity.y += gravity * delta

	# Processa o pular no espaço / clique do mouse
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_impulse
 
	# Aplica o movimento e detecta colisões com chão/canos
	var collided = move_and_slide()
	
	#aplicando rotação ao sprite
	# Inclina o pássaro para cima ao subir e para baixo ao cair
	if velocity.y < 0:
		rotation = deg_to_rad(-10)
	else:
		rotation = lerp_angle(rotation, deg_to_rad(50), 0.1)
	
	if collided and is_live:
		die()
	
func die() -> void:
	
	if not is_live:
		return
	is_live = false
	$Skin01.stop()
	died.emit()
