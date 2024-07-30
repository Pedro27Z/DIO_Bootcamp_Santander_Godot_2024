extends Node

export var initial_spawn_rate: float = 60.0
export var spawn_rate_per_minute: float = 30
export var wave_duration: float = 20.0
export var break_intensity: float = 0.5
export var mob_spawner_path: NodePath 

var time_ative: float = 0.0
var mob_spawner: MobSpawner = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node(mob_spawner_path):
		mob_spawner = get_node(mob_spawner_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.is_game_over == true: return
	
#	if mob_spawner == null:
#		return
		
	time_ative += delta
#    dificuldade linear
	var spawn_rate = initial_spawn_rate + (spawn_rate_per_minute * (time_ative/60.0))
#	 dificuldade sinoidal (sistema de ondas)
	var sin_wave = sin((time_ative * TAU)/ wave_duration)
	var wave_factor = custom_remap(sin_wave, -1.0, 1.0, 0.0, break_intensity) 
	spawn_rate += wave_factor
	mob_spawner.mob_per_minute = spawn_rate 
#	print(mob_spawner.mob_per_minute)
	pass
	
func custom_remap(value, istart, istop, ostart, ostop):
#	if abs(istart - istop) < 0.0001:
#		return ostart + ((ostop + ostart) / 2.0) * (((value - istart)) / (istop - istart)) #(ostart + ostop) / 2.0
	return ostart + (ostop - ostart) * ((value - istart) / (istop - istart))
