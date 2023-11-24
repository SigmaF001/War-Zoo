extends Node2D

class_name  GameManager

signal toggle_game_paused(is_paused : bool)
signal toggle_player_dead(player_is_died : bool)

func _ready():
	PlayerDead.connect("PlayerDead", when_player_dead)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

var player_dead : bool = false:
	get:
		return player_dead
	set(value):
		player_dead = value
		get_tree().paused = player_dead
		emit_signal("toggle_player_dead", player_dead)

func _input(event : InputEvent):
	if (event.is_action_pressed("esc")):
		if (player_dead == false):
			game_paused = !game_paused
		
func when_player_dead():
	player_dead = !player_dead

func _on_resume_pressed():
	game_paused = !game_paused
	

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scence/main_menu.tscn")
	game_paused = !game_paused


func _on_quit_from_died_pressed():
	get_tree().change_scene_to_file("res://Scence/main_menu.tscn")
	player_dead = !player_dead
