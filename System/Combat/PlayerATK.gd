extends Area2D

func _process(delta):
	look_at(get_global_mouse_position())

func _on_area_entered(area: Area2D):
	AttackSignal.emit_signal("Player_Attack")
