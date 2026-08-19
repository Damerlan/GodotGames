extends Node2D

@export var velocidade_jogo: float = 300.0
@export var velocidade_carro: float = 250.0

@onready var pista:Parallax2D = $Pista
@onready var jogador: Area2D = $Jogador

#limites laterais para o carro nao sair do asfalto
var limite_esquerdo: float = 200.0
var limite_direito: float = 400.0

@onready var spawner: Node2D = $SpawnerManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	# 1. Faz o Parallax2D rolar usando o autoscroll por código
	pista.autoscroll.y = velocidade_jogo

	# 2. Movimento lateral do carro
	var direcao = Input.get_axis("ui_left", "ui_right")
	jogador.position.x += direcao * velocidade_carro * delta
	
	# Trava o carro dentro das bordas da pista
	jogador.position.x = clamp(jogador.position.x, limite_esquerdo, limite_direito)

	# Chama o spawner passando o delta e a velocidade atual!
	spawner.atualizar_spawns(delta, velocidade_jogo - 180.0)

	# Atualiza o movimento de cada carro/obstáculo spawned na tela
	#for filho in get_children():
	#	if filho.has_method("mover"):
	#		filho.mover(velocidade_atual, delta)
