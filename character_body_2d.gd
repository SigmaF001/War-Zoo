extends CharacterBody2D

@onready var animation_sprite : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

@export var speed : float = 1000.0

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_sprite.play("idle")

func _process(delta):
	walk()
	move_and_slide()
	
	
func walk():
	direction = Input.get_vector("left","right","up","down")
	
	velocity = direction * speed
