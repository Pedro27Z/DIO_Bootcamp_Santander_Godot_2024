extends Node

signal game_over_signal

onready var is_game_over: bool = false 

export (String) var main_scene_path: String = "res://scenes/Main.tscn" #scene path

onready var player: Player
onready var player_position: Vector2
onready var enemy: Enemy
onready var enemy_position: Vector2

onready var timelapse: float = 0.0
onready var timelapse_string: String
onready var counter_kill_monsters: int = 0

func _ready():
	pass 

func _process(delta):
	if is_game_over: return

	timelapse += delta
	var time_seconds: int = timelapse
	var seconds: int = time_seconds % 60
	var minutes: int = time_seconds / 60
	timelapse_string = "%02d:%02d" % [minutes, seconds]
	pass

func end_game():
	if is_game_over: return
	is_game_over = true
	emit_signal("game_over_signal")

func reset():
	player = null
	player_position = Vector2.ZERO
	timelapse = 0.0
	timelapse_string = "00:00"
	counter_kill_monsters = 0
	is_game_over = false

func restart_main_scene():
	# Carrega a cena principal
	var main_scene = load(main_scene_path)		
	get_tree().change_scene_to(main_scene)



