class_name Item
extends Node

export var heal_amount: int
export var item_name: String
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	$Area2D
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

#	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		var player: Player = body
		player._heal(heal_amount)
		queue_free()
