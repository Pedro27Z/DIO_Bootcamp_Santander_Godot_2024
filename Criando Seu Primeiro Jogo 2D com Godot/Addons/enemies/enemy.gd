class_name Enemy
extends Node2D
export var health: int = 10
export var death_play: PackedScene 
export var enemy_name: String
export var damage_in_player: int = 1
export var drop_chance: float = 0.1
export var drop_chance_itens: Array = []
export var drop_itens: Array = []

onready var enemy: Enemy = self
onready var position_2d: Position2D = $Position2D
onready var enemy_collision: CollisionShape2D = $CollisionShape2D
var damage_digit_prefab: PackedScene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	damage_digit_prefab = preload("res://scenes/Label_health_enemies.tscn")
	GameManager.enemy = self
	
func _process(delta):
	GameManager.enemy_position = position
	z_index = int(global_position.y)

#	sortY()
	pass
	
func damage(amount:int):
	health -= amount
	modulate = Color.red
	var tween = create_tween().tween_property(self, "modulate", Color.white, 0.3)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	
#	 mostrar o dano no inimigo
	var damage_digit = damage_digit_prefab.instance()
	damage_digit.value = amount
	if damage_digit.value > health && health > 0:
		damage_digit.value = abs(damage_digit.value - health)
	if position_2d:
		damage_digit.global_position = position_2d.global_position
	else:
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
	
	if health <= 0:
		GameManager.counter_kill_monsters += 1
		die()
		
func die ():
	if death_play:
		var death_object = death_play.instance()
		death_object.position = position
		get_parent().add_child(death_object)
	if randf() <= drop_chance:
		drop()
	queue_free()
	
func get_rand_drop_item ():
	if drop_itens.size() == 1:
		return drop_itens[0]
		
	var max_chance: float = 0.0
	for drop_chance_item in drop_chance_itens:
		max_chance += drop_chance_item
	
	var random_value = randf() * max_chance
	var seta: float = 0.0
	for i in drop_itens.size():
		var drop_item = drop_itens[i]
		var drop_choice = drop_chance_itens[i] if i > drop_chance_itens.size() else 1
		if random_value <= drop_chance + seta:
			return drop_item
		seta += drop_choice
	return null	
	
		
func drop():
	if drop_itens.size() > 0:
	   var drop_scene = get_rand_drop_item()
	   if drop_scene:
		   var drop = drop_scene.instance()
		   drop.position = position
		   get_parent().add_child(drop)
	

