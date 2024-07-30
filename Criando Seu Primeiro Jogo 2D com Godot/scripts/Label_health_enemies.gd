extends Node2D

export var value:int = 0

onready var label: Label = $Node2D/Label
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
