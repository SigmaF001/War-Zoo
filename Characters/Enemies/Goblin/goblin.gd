extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var goblin_sprite : Sprite2D = $Sprite2D
@onready var player = $"../Chincilla"
@onready var motion = Vector2.ZERO

@export var atk_damage : float = 15.0
@export var goblin : CharacterBody2D
@export var speed : float = 3.0

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
		$Hitbox/CollisionShape2D.position.x = -11.6 
	if (player.position.x > goblin.position.x):
		goblin_sprite.flip_h = false
		$Hitbox/CollisionShape2D.position.x = 11.6 

func _on_hitbox_body_entered(body):
	pass
