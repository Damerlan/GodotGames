class_name CarAdv
extends Area2D

@export var texturas_carros: Array[Texture2D] = []
@export var velocidade_propria: float = 100.0
# Definimos uma velocidade base padrão para descer a pista
@export var velocidade_pista_padrao: float = 300.0

#variaçao: carros que trocam de faixa
@export var muda_de_faixa: bool = false
var direcao_faixa: float = 1.0
var velocidade_faixa: float = 80.0

# Velocidade base para dar espaço ao jogador
@export var velocidade_descida_base: float = 200.0 
@export var vel_troca_faixa: float = 90.0 # Velocidade lateral suave

@export var escala_sprite: Vector2 = Vector2(0.8, 0.8) # Define a escala desejada (0.8 no X e Y)


@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Reduz o tamanho do sprite do carro automaticamente quando ele nascer
	if sprite:
		sprite.scale = escala_sprite
		
	#escolha um modelo visual aleatório para esse carro
	if texturas_carros.size() > 0:
		sprite.texture = texturas_carros.pick_random()
		
		#randomiza se este carro em especifico vai ser um trocador de faixa
		if randf() > 0.6:
			muda_de_faixa = true
			direcao_faixa = [-1.0, 1.0].pick_random()

func mover(velocidade_pista: float, delta: float) -> void:
	#Movimento vertical relativo à velocidade da pista
	position.y += (velocidade_pista - velocidade_propria) * delta
	
	#logica do carro que troca sozinho
	if muda_de_faixa:
		position.x += direcao_faixa * velocidade_faixa * delta
		if position.x < 120 or position.x > 380: #bateu na borda, inverte a direção
			direcao_faixa *= -1.0
	
	#limpeza de memoria
	if position.y > 700:
		queue_free()
			


func _process_old(delta: float) -> void:
	# Agora o próprio nó executa isso a cada frame do jogo!
	position.y += (velocidade_pista_padrao - velocidade_propria) * delta

	# Lógica do carro trocando de faixa (se houver)
	if muda_de_faixa:
		position.x += direcao_faixa * velocidade_faixa * delta
		if position.x < 200 or position.x > 370:
			direcao_faixa *= -1.0

	# Limpeza de memória ao sair por baixo da tela
	if position.y > 700:
		queue_free()

func _process(delta: float) -> void:
	# Desce mais devagar que a pista inteira para o jogador poder ultrapassar
	position.y += velocidade_descida_base * delta

	if muda_de_faixa:
		position.x += direcao_faixa * vel_troca_faixa * delta
		# Mantém a troca apenas dentro das bordas das faixas (Ajuste os valores para o seu mapa)
		if position.x < 210.0 or position.x > 360.0:
			direcao_faixa *= -1.0

	if position.y > 750:
		queue_free()
