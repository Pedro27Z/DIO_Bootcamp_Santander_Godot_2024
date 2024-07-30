extends Node2D

export var damage_amount: int = 2

onready var special_hitbox: Area2D = $Area2D
onready var animation: AnimationPlayer = $AnimationPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("agora vai")
	$Special_sound.play()
	animation.connect("animation_finished", self, "_on_animation_finished")
	set_process(true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	pass

func deal_damage(damage = 2):
	var bodies = special_hitbox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemies"):
			var enemy: Enemy = body
			enemy.damage(damage)
			
func _on_animation_finished(anim_name):
	if anim_name == "agora vai": 
		queue_free()  

