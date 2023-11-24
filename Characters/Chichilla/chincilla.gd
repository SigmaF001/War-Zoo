extends CharacterBody2D

@export var speed : float = 250.0

@onready var animation_sprite : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var malee_range = $MaleeAtk/CollisionShape2D
@onready var health_bar = $UI/HealthBar
@onready var collision_sprite = $CollisionShape2D
@onready var collision_hitbox = $Hitbox/CollisionShape2D

var max_health = 400
var health = max_health

var enemy_attack_rang = false
var enemy_attack_cooldown = true
var player_alive = true

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_sprite.play("idle_side")
	health_bar.max_value = max_health
	set_health_bar()

func set_health_bar():
	health_bar.value = health

func handle_input():
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * speed

func _process(delta):
	handle_input()
	move_and_slide()
	animation_movement()
	facing_direction()
	set_health_bar()
	enemy_attack()
	player_attack()
	player_dead()


func animation_movement():
	if (direction != Vector2.ZERO):
		animation_sprite.play("run")


func facing_direction():
	if (direction == Vector2.LEFT):
		sprite.flip_h = false
		collision_sprite.position.x = -10
		collision_hitbox.position.x = -10
	if (direction == Vector2.RIGHT):
		sprite.flip_h = true
		collision_sprite.position.x = 10
		collision_hitbox.position.x = 10

func _on_hitbox_body_entered(body):
	if body.is_in_group("Goblin"):
		enemy_attack_rang = true


func _on_hitbox_body_exited(body):
	if body.is_in_group("Goblin"):
		enemy_attack_rang = false

func enemy_attack():
	if enemy_attack_rang:
		health -= 1

func player_dead():
	if health == 0:
		PlayerDead.emit_signal("PlayerDead")
		

func player_attack():
	if Input.is_action_just_pressed("attack"):
		AttackSignal.emit_signal("Player_Attack")
		malee_range.disabled = false
		$Timer.start()


func _on_timer_timeout():
	malee_range.disabled = true
