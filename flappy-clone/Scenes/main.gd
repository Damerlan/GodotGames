extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_y_min: float = 200.0
@export var spawn_y_max: float = 500.0

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var pipe_timer: Timer = $PipeTimer
@onready var bird: CharacterBody2D = $Bird

@onready var game_over_menu: Control = $CanvasLayer/GameOverMenu
@onready var high_score_label: Label = $CanvasLayer/GameOverMenu/HighScoreLabel
#background
@onready var parallax_2d: Parallax2D = $BackgroundParallax

@onready var parrallax_2d2: Parallax2D = $GroundParallax

var high_score: int = 0
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
	
	# Para o movimento automático do Parallax2D
	parallax_2d.autoscroll = Vector2.ZERO
	# Para o movimento automático do Parallax2D2
	parrallax_2d2.autoscroll = Vector2.ZERO
	
	# Para o movimento de todos os canos existentes na tela
	get_tree().call_group("pipes", "set_process", false)
	
	# Atualiza o recorde
	if score > high_score:
		high_score = score
	
	high_score_label.text = "Pontos: " + str(high_score)
	game_over_menu.visible = true


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
