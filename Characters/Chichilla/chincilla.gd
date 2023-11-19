extends CharacterBody2D

@export var speed : float = 300.0

@onready var animation_sprite : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_sprite.play("idle_side")

func handle_input():
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed

func _process(delta):
	handle_input()
	move_and_slide()
	animation_movement()
	facing_direction()
	
func animation_movement():
	if (direction == Vector2.LEFT):
		animation_sprite.play("walk_side")
	if (direction == Vector2.RIGHT):
		animation_sprite.play("walk_side")
	if (direction == Vector2.ZERO):
		animation_sprite.play("idle_side")
	if (direction == Vector2.DOWN):
		animation_sprite.play("walk_down")
	if (direction == Vector2.UP):
		animation_sprite.play("walk_down")
		
func facing_direction():
	if (direction == Vector2.LEFT):
		sprite.flip_h = false
	if (direction == Vector2.RIGHT):
		sprite.flip_h = true
	if (direction == Vector2.DOWN):
		sprite.flip_v = false
	if (direction == Vector2.UP):
		sprite.flip_v = true
