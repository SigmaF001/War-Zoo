extends CanvasLayer

@export var game_manager : GameManager

func _ready():
	hide()
	game_manager.connect("toggle_player_dead", _on_game_manager_toggle_player_dead)

func _process(delta):
	pass

func _on_game_manager_toggle_player_dead(player_is_died : bool):
	if (player_is_died):
		show()
	else :
		hide()
