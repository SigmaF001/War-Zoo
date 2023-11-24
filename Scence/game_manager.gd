extends Node2D

class_name  GameManager

signal toggle_game_paused(is_paused : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _input(event : InputEvent):
	if (event.is_action_pressed("esc")):
		game_paused = !game_paused
		


func _on_resume_pressed():
	game_paused = !game_paused
	


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scence/main_menu.tscn")
	game_paused = !game_paused
