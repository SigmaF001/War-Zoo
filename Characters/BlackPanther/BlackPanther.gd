extends CharacterBody2D

@onready var animation_sprite = $AnimationPlayer
@onready var blackpanther_sprite = $Sprite2D
@onready var player = get_parent().get_parent().get_node("Chincilla")
@onready var SoftCollision = $SoftCollision

@export var blackpanther : CharacterBody2D

var player_is_atk = false
var speed = 1
var max_health = 300
var health = max_health

func _ready():
	animation_sprite.play("walk")
	PlayerAtk.connect("Player_Attack", took_damage)

func took_damage(sender, took_damage):
	print("damage")
	animation_sprite.play("hurt")
	health -= PlayerStatus.attack_damage

func _process(delta):
	var direction : Vector2 = (player.global_position - global_position).normalized()
	velocity = direction * speed
	
	if SoftCollision.is_colliding():
		velocity += SoftCollision.get_push_vector() * delta * 100
		
	move_and_collide(velocity)
	facing_direction()
	take_damage()
	dying()

func facing_direction():
	if (player.position.x < blackpanther.position.x):
		blackpanther_sprite.flip_h = false
		$AttackRange/CollisionShape2D.position.x = -112
		$Hitbox/CollisionShape2D.position.x = -112
	if (player.position.x > blackpanther.position.x):
		blackpanther_sprite.flip_h = true
		$AttackRange/CollisionShape2D.position.x = 112
		$Hitbox/CollisionShape2D.position.x = 112


func _on_hitbox_area_entered(area):
	if area.is_in_group("PlayerAttack"):
		animation_sprite.play("hurt")
		player_is_atk = true


func _on_hitbox_area_exited(area):
	if area.is_in_group("PlayerAttack"):
		animation_sprite.play("walk")
		player_is_atk = false

func take_damage():
	if player_is_atk:
		health -= PlayerStatus.attack_damage

func dying():
	if health == 0:
		queue_free()
