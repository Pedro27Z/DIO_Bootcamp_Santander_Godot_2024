class_name GameOverUI
extends Node2D


onready var game_over_ui_self = self
onready var game_ui: CanvasLayer = $UI
onready var camera_main: Camera2D = $Camera2D
onready var audio_play: AudioStreamPlayer = $AudioStreamPlayer

export var game_over_ui_template: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_play.play()
	$"/root/GameManager".connect("game_over_signal", game_over_ui_self, "trigger_game_over" )
	pass # Replace with function body.

func trigger_game_over():
	if game_ui:
		game_ui.queue_free()
		game_ui = null
		
	var game_over_ui = game_over_ui_template.instance()
	add_child(game_over_ui)
	
func on_game_over():
	game_ui.timer_label = GameManager.timelapse_string
	pass
	
	

