extends Area2D



func _on_area_entered(area: Area2D):
	area.get_parent().queue_free()
