extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_y_min: float = 200.0
@export var spawn_y_max: float = 500.0

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var pipe_timer: Timer = $PipeTimer
@onready var bird: CharacterBody2D = $Bird

var score: int = 0

func _ready() -> void:
	bird.died.connect(_on_bird_died)
	pipe_timer.timeout.connect(_spawn_pipe)
	pipe_timer.start(1.5)

func _spawn_pipe() -> void:
	if pipe_scene == null:
		return
		
	var new_pipe = pipe_scene.instantiate()
	var random_y = randf_range(spawn_y_min, spawn_y_max)
	
	# Posição X inicial fora da tela à direita (ajuste conforme a largura da janela)
	new_pipe.position = Vector2(600, random_y)
	add_child(new_pipe)

func add_score() -> void:
	score += 1
	score_label.text = str(score)

func _on_bird_died() -> void:
	pipe_timer.stop()
	
	# Aguarda 1.5 segundo e reinicia a cena
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
