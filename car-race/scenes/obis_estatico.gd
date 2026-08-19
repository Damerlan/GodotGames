class_name obisEstatico
extends Area2D

enum Tipo {BURACO, OLEO}
@export var tipo_obistaculo: Tipo = Tipo.BURACO

@export var textura_buraco: Texture2D
@export var textura_oleo: Texture2D

@export var velocidade_pista: float = 300.0 # Igual à velocidade que a pista rola!

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if tipo_obistaculo == Tipo.BURACO:
		sprite.texture = textura_buraco
	else:
		sprite.texture = textura_oleo

func mover(velocidade_pista: float, delta: float) -> void:
	# Obstáculos estáticos descem na velocidade exata da pista
	position.y += velocidade_pista * delta
	
	if position.y > 700:
		queue_free()


func _process(delta: float) -> void:
	position.y += velocidade_pista * delta
	
	if position.y > 750:
		queue_free()
