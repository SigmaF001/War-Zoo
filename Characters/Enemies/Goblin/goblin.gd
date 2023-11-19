extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var goblin_sprite : Sprite2D = $Sprite2D
@onready var player = $"../Chincilla"
@onready var motion = Vector2.ZERO

@export var goblin : CharacterBody2D
@export var speed : float = 2.0

func _ready():
	animation.play("idle")

func _physics_process(delta):
	motion = position.direction_to(player.position) * speed
	motion = move_and_collide(motion)
	
	if (motion == null):
		animation.play("run")
		
	facing_direction()

func facing_direction():
	if (player.position.x < goblin.position.x):
		goblin_sprite.flip_h = true
	if (player.position.x > goblin.position.x):
		goblin_sprite.flip_h = false
