extends Area2D

@export var velocidade_movimento: float = 300.0
@export var limite_esquerdo: float = 200.0
@export var limite_direito: float = 370.0

# Variáveis do efeito do Óleo (Derrapagem)
var esta_derrapando: bool = false
var tempo_derrapagem: float = 0.0
var direcao_derrapagem: float = 0.0

# Referência à velocidade da pista (se estiver controlada na MainScene ou no jogo)
var velocidade_atual_pista: float = 400.0

func _process(delta: float) -> void:
	var direcao_x = Input.get_axis("ui_left", "ui_right")
	
	if esta_derrapando:
		# Durante o óleo, o jogador perde controle e é empurrado pro lado
		tempo_derrapagem -= delta
		position.x += direcao_derrapagem * (velocidade_movimento * 1.2) * delta
		
		if tempo_derrapagem <= 0.0:
			esta_derrapando = false
	else:
		# Controle normal no teclado
		position.x += direcao_x * velocidade_movimento * delta

	position.x = clamp(position.x, limite_esquerdo, limite_direito)


func _on_area_entered(area: Area2D) -> void:
	if area is CarAdv:
		print("BATEU NO CARRO! Game Over.")
			
	elif area is obisEstatico:
		if area.tipo_obistaculo == obisEstatico.Tipo.BURACO:
			print("Caiu no Buraco! Velocidade reduzida.")
			# Aplica penalidade de velocidade (Ex: reduz temporariamente)
			velocidade_atual_pista = max(150.0, velocidade_atual_pista - 150.0)
			
		elif area.tipo_obistaculo == obisEstatico.Tipo.OLEO:
			print("Derrapou no Óleo!")
			esta_derrapando = true
			tempo_derrapagem = 0.6 # Derrapa por meio segundo
			# Empurra o jogador aleatoriamente para a esquerda (-1) ou direita (1)
			direcao_derrapagem = [-1.0, 1.0].pick_random()
				
			area.queue_free() # Destrói o obstáculo ao passar por cima
