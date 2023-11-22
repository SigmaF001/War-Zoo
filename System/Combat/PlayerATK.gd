extends Area2D

var player_atk_dmg = 10

func _on_area_entered(area: Area2D):
	area.get_parent().queue_free()
