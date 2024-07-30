extends CanvasLayer

onready var time_label: Label = $Game_Over_Panel2/CenterContainer/GridContainer/Game_Over_Label_2_1_Num
onready var monster_label: Label = $Game_Over_Panel2/CenterContainer/GridContainer/Game_Over_Label_2_2_Num

export var restart_delay: float = 5.0
var restart_cooldown: float
var kill_monsters: int


# Called when the node enters the scene tree for the first time.
func _ready():
	time_label.text = GameManager.timelapse_string
	monster_label.text = str(GameManager.counter_kill_monsters) 
	restart_cooldown = restart_delay
	pass # Replace with function body.



func _process(delta: float) -> void:
	restart_cooldown -= delta
	if restart_cooldown <= 0.0:
		pass
		restart_game()
	 

func restart_game():
	GameManager.reset()
	GameManager.restart_main_scene()
	
