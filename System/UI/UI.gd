extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tranform_cooldown_timeout():
	$TranformButton.value += 1


func _on_super_punch_cooldown_timeout():
	$SuperPunch.value += 1
