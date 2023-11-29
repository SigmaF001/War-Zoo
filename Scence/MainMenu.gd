extends Control



func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scence/game_manager.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	$AnimatedSprite2D.play("Play")
