class_name MobSpawner
extends Node2D

onready var mob_self: MobSpawner = self
onready var path2D: Path2D = $Path2D
onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
onready var water_tilemap_node: TileMap = null

var cooldown: float = 0.0

export var bestiary: Array = [PackedScene]
export var mob_per_minute: float = 60.0
export var water_tilemap: NodePath # Export a node path to set in the editor
export var max_attempts: int = 30 # Maximum attempts to find a valid spawn point

func _ready():
	water_tilemap_node = get_node(water_tilemap).get_child(0)
	pass # Replace with function body.

func _process(delta: float):
	#parar de produzir monstros
	if GameManager.is_game_over == true: 
		return
		
	cooldown -= delta #temporizador
	if cooldown > 0: return
	
	var interval = 60.0 / mob_per_minute #frequency
	cooldown = interval
#
	var index: int = (rand_range(0, bestiary.size() )) # instanciar criatura aleatória
	var criatura_criada = bestiary[index]
	var criatura = criatura_criada.instance()
	
	var spawn_point = get_point()
	var attempts = 0
	while is_position_on_water(spawn_point) and attempts < max_attempts:
		spawn_point = get_point()
		attempts += 1
		
	if not is_position_on_water(spawn_point):
		criatura.global_position = spawn_point
		get_parent().add_child(criatura)
	else:
		print("Failed to find valid spawn point after", max_attempts, "attempts.")
	pass

func get_point() -> Vector2:
	path_follow.unit_offset = randf()
	return path_follow.global_position
	
func is_position_on_water(position: Vector2) -> bool:
	var tilemap_position = water_tilemap_node.world_to_map(position)
	var cell = water_tilemap_node.get_cellv(tilemap_position)
	return cell != TileMap.INVALID_CELL
		
	





