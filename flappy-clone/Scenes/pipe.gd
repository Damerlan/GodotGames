extends Node2D

@export var speed: float = 150.0

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#move o conjunto de camps para a esquerda
	position.x -= speed * delta
	
	#destroi o cano quando sair da tela ajustar de a cordo com a resolução da tela
	if position.x < -100:
		queue_free()


func _on_top_pipe_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()



func _on_bottom_pipe_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()


func _on_score_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Avisa o jogo principal para somar 1 ponto
		var main = get_tree().current_scene
		if main.has_method("add_score"):
			main.add_score()
