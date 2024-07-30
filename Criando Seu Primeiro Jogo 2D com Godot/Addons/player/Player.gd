class_name Player
extends KinematicBody2D
onready var sprite = $PawnBlue
onready var animation_player = $AnimationPlayer
onready var sword_hitbox = $Sword_area
onready var player_hurtbox = $Hurt_area
onready var player_health_bar: ProgressBar = $Player_Health_Bar

export var health: int = 100
export var max_health: int = 100
export var death_play: PackedScene
export var sword_damage: int = 2

export var interval_special: float = 15.0
export var special_scene: PackedScene
export var special_cooldown: float = 0.0

var is_running: bool = false
var is_attacking: bool = false
var damage_cooldown: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player = self
	animation_player.connect("animation_finished", self, "_on_animation_finished")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GameManager.player_position = position
	z_index = int(global_position.y)
	
	if GameManager.timelapse >= 15:
		special_update(delta)
	player_health_bar.value = health
	player_health_bar.max_value = max_health
	
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.15)
	var speed = 5
	if is_attacking:
		speed *= 0.5
	var target_velocity = input_vector * speed * 100
	var velocity = Vector2()
	velocity = lerp(velocity, target_velocity, 0.15)
	
	if is_attacking:
		return
		
	if input_vector.x != abs(0) || input_vector.y != abs(0):
		is_running = true
		if input_vector.x > 0:
			sprite.flip_h = false
		elif input_vector.x < 0:
			sprite.flip_h = true
		if not is_attacking:
			animation_player.play("Run")
	else:
		is_running = false
		if not is_attacking:
			animation_player.play("Idle")
		
	if Input.is_action_just_pressed("Button_A") && not is_attacking :
		is_attacking = true
		animation_player.play("Attack_1")
		
		
	if Input.is_action_just_pressed("Button_B") && not is_attacking :
		is_attacking = true
		animation_player.play("Attack_2")
		
		
	move_and_slide(target_velocity, velocity)
	_process_damage_player(delta)
	
	
	
func _on_animation_finished(anim_name):
	if anim_name == "Attack_1" || anim_name == "Attack_2":
		is_attacking = false
		
func _play_sound():
	$Attack_1.play()

func _deal_damage_enemies():
	var bodies = sword_hitbox.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemies"):
			var enemy: Enemy = body
			var direction_enemy = (enemy.position - position).normalized()
			var atk_direction: Vector2 
			$Damage_enemy.play()
			if sprite.flip_h:
				atk_direction = Vector2.LEFT
			else:
				atk_direction = Vector2.RIGHT
			var dot_produt = direction_enemy.dot(atk_direction)
		
			if dot_produt >= 0.2:
				enemy.damage(sword_damage)
				

func _process_damage_player(delta: float):
	damage_cooldown -= delta
	
	if damage_cooldown > 0: return
	
	damage_cooldown = 0.5
	
	var bodies = player_hurtbox.get_overlapping_bodies()
	
	
	for body in bodies:
		if body.is_in_group("Enemies"):
			var enemy: Enemy = body
			var damage_amount = enemy.damage_in_player
			_damage(damage_amount)
			$Damage.play()

func _damage(amount:int):
	if health <= 0: return
	
	health -= amount
	modulate = Color.firebrick
	var tween = create_tween().tween_property(self, "modulate", Color.white, 0.3)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	if health <= 0:
		_die()
		
func _die ():
	
	if death_play:
		var death_object = death_play.instance()
		var anim: Sprite = death_object.get_child(0)
		var camera: Camera2D = death_object.get_child(1)
		death_object.position = position
		anim.scale = Vector2(2, 2)
		get_parent().add_child(death_object)
#	
	queue_free()
	
	GameManager.end_game()
	
func _heal (amount: int):
	health += amount
	if health > max_health:
		health = max_health
	modulate = Color.green
	var tween = create_tween().tween_property(self, "modulate", Color.white, 0.3)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	return health
	
func special_update(delta: float):
	special_cooldown -= delta
	if special_cooldown > 0: return
	special_cooldown = interval_special
	var special = special_scene.instance()
	add_child(special)
	pass

