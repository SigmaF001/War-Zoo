extends CanvasLayer

@export var game_manager : GameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _process(delta):
	pass
	
func _on_game_manager_toggle_game_paused(is_paused : bool):
	if (is_paused):
		show()
	else :
		hide()
