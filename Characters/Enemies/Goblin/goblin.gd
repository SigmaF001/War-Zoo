extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var goblin_sprite : Sprite2D = $Sprite2D

@export var goblin : CharacterBody2D
@export var speed : float = 10.0

var motion = Vector2.ZERO
var player = null


func _ready():
	animation.play("idle")

func _physics_process(delta):
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
	motion = move_and_collide(motion)
	movement()

func _on_area_2d_body_entered(body):
	print("entered")
	player = body

func _on_area_2d_body_exited(body):
	print("exit")
	player = null

func movement():
	if player:
		animation.play("run")
		if (player.position.x < goblin.position.x):
			goblin_sprite.flip_h = true
		elif (player.position.x > goblin.position.x):
			goblin_sprite.flip_h = false
			
	elif player == null:
		animation.play("idle")
	
	
