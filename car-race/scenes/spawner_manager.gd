extends Node2D

# Precarrega as duas cenas totalmente separadas
@export var cena_carro: PackedScene
@export var cena_obstaculo: PackedScene

var limites_faixas: Array[float] = [ 250.0, 360.0] #140.0, Posições pré-definidas das faixas
var tempo_spawn: float = 0.0

func atualizar_spawns(delta: float, velocidade_pista: float) -> void:
	if velocidade_pista < 50.0:
		return

	tempo_spawn -= delta
	if tempo_spawn <= 0.0:
		spawn_objeto_aleatorio()
		tempo_spawn = randf_range(2.0, 3.5)

func spawn_objeto_aleatorio_old() -> void:
	var pos_x = limites_faixas.pick_random()
	var tipo_spawn = randi() % 2 # 0: Carro, 1: Obstáculo

	if tipo_spawn == 0:
		var novo_carro = cena_carro.instantiate() as CarAdv
		novo_carro.position = Vector2(pos_x, -60.0)
		get_parent().add_child(novo_carro) # Adiciona na cena principal
	else:
		var novo_obstaculo = cena_obstaculo.instantiate() as obisEstatico
		# Sorteia se é buraco ou óleo na própria instância
		novo_obstaculo.tipo_obistaculo = obisEstatico.Tipo.values().pick_random()
		novo_obstaculo.position = Vector2(pos_x, -60.0)
		get_parent().add_child(novo_obstaculo)

func spawn_objeto_aleatorio() -> void:
	var pos_x = limites_faixas.pick_random()
	# Sorteio com 70% de chance de ser Carro e 30% de ser Obstáculo
	var eh_carro = randf() > 0.4 # 60% chance de carro, 40% obstáculo

	if eh_carro:
		var novo_carro = cena_carro.instantiate()
		novo_carro.position = Vector2(pos_x, -80.0) # Nasce bem acima da tela
		get_parent().add_child(novo_carro)
	else:
		var novo_obstaculo = cena_obstaculo.instantiate() as obisEstatico
		# Sorteia 0 (BURACO) ou 1 (OLEO)
		novo_obstaculo.tipo_obistaculo = obisEstatico.Tipo.values().pick_random()
		novo_obstaculo.position = Vector2(pos_x, -80.0)
		get_parent().add_child(novo_obstaculo)
