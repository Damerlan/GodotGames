extends Line2D

@export var length: int = 100
@export var speed: float = 150.0 # Use a mesma velocidade dos canos!

@onready var target: Node2D = get_parent()

func _ready() -> void:
	top_level = true
	show_behind_parent = true

func _physics_process(delta: float) -> void:
	if target == null:
		return

	# 1. Move todos os pontos já existente para a esquerda (simulando a velocidade do mapa)
	for i in range(get_point_count()):
		var current_pos = get_point_position(i)
		set_point_position(i, current_pos - Vector2(speed * delta, 0))

	# 2. Adiciona o ponto atual na posição da bunda do gato
	# O Vector2(-15, 0) ajusta para o rastro sair exatamente de trás dele
	add_point(target.global_position + Vector2(-15, 0))

	# 3. Mantém o tamanho do rastro limitado
	while get_point_count() > length:
		remove_point(0)
