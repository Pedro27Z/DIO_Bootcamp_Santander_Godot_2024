class_name UI
extends CanvasLayer
onready var timer_label: Label = $Panel2/Time_Label

func _ready():
	pass

func _process(delta: float):
	if GameManager.is_game_over == true: return

	timer_label.text = GameManager.timelapse_string
	pass
