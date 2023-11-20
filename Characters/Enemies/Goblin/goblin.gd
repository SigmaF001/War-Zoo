extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var goblin_sprite : Sprite2D = $Sprite2D
@onready var player_character = get_parent().get_parent().get_node("Chincilla")
@onready var SoftCollision = $SoftCollision

@export var atk_damage : float = 15.0
@export var goblin : CharacterBody2D
@export var speed : float = 3

var player = null
var player_chase = false

func _ready():
	animation.play("run")

func _physics_process(delta):
	if SoftCollision.is_colliding():
		velocity += SoftCollision.get_push_vector() * delta * 1000
	
#	if player_chase:
#		position += (player_character.position - position) / speed
	var direction : Vector2 = (player_character.global_position - global_position).normalized()
	
	move_and_collide(direction * speed)
	
	facing_direction()

func facing_direction():
	if (player_character.position.x < goblin.position.x):
		goblin_sprite.flip_h = true
		$Hitbox/CollisionShape2D.position.x = -11.6 
	if (player_character.position.x > goblin.position.x):
		goblin_sprite.flip_h = false
		$Hitbox/CollisionShape2D.position.x = 11.6
	pass 

func _on_hitbox_body_entered(body):
	pass


func _on_find_player_body_entered(body):
	player = player_character
	player_chase = true
