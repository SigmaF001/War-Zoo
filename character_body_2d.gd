extends CharacterBody2D

@onready var animation_sprite : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

@export var speed : float = 800.0

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_sprite.play("idle")

func _process(delta):
	walk()
	move_and_slide()
	facing_direction()
	
func walk():
	direction = Input.get_vector("left","right","up","down")
	
	velocity = direction * speed
	
	if(direction != Vector2.ZERO):
		animation_sprite.play("run")
	elif (direction == Vector2.ZERO):
		animation_sprite.play("idle")
		
func facing_direction():
	if (direction == Vector2.LEFT):
		sprite.flip_h = true
	elif (direction == Vector2.RIGHT):
		sprite.flip_h = false

