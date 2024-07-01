extends Label

func _ready():

	set_process(true)
	
func _process(delta):
	var format_string = "%010d"
	var actual_string = format_string % [GameState.player_score]
	text = str(actual_string)
