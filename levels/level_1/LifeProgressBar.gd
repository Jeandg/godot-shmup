extends TextureProgressBar

func _ready():
	set_process(true)
	
func _process(delta):
	value = GameState.player_life
	max_value = 100
