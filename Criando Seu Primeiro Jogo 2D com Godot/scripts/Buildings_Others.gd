class_name Build
extends KinematicBody2D

onready var building: KinematicBody2D = self
onready var area_collision: CollisionShape2D = $CollisionShape2D
# Declare member variables here. Examp
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	z_index = int(global_position.y)
	pass
	

