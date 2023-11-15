extends CharacterBody2D

var speed : float = 1000.0
var direction : Vector2 = Vector2.ZERO


func _process(delta):
	walk()
	
	move_and_slide()
	
	
func walk():
	direction = Input.get_vector("left","right","up","down")
	
	velocity = direction * speed
