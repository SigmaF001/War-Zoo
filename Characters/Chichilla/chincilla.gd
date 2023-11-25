extends CharacterBody2D

@export var speed : float = 250.0

@onready var animation_sprite : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var malee_range = $MaleeAtk/CollisionShape2D
@onready var health_bar = $UI/HealthBar
@onready var mana_bar = $UI/ManaBar
@onready var collision_sprite = $CollisionShape2D
@onready var collision_hitbox = $Hitbox/CollisionShape2D
@onready var attack_animation = $MaleeAtk/AnimationPlayer

var max_health = 400
var health = max_health

var max_mana = 100
var mana = 0

var enemy_attack_rang = false
var enemy_attack_cooldown = true
var player_alive = true
var blackpanther_attack = false

var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_sprite.play("idle")
	attack_animation.play("none")
	health_bar.max_value = max_health
	mana_bar.max_value = max_mana
	set_health_bar()
	set_mana_bar()
	$MaleeAtk/CollisionShape2D.position.x = 193.469
	$MaleeAtk/CollisionShape2D.position.y = -17.5

func set_health_bar():
	health_bar.value = health

func set_mana_bar():
	mana_bar.value = mana

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
	charge_mana()
	set_mana_bar()


func animation_movement():
	if (direction != Vector2.ZERO):
		animation_sprite.play("run")
	if (direction == Vector2.ZERO):
		animation_sprite.play("idle")


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
	pass


func _on_hitbox_body_exited(body):
	pass

func enemy_attack():
	if enemy_attack_rang:
		health -= 1
	if blackpanther_attack:
		health -= BlackPantherStatus.attack_damage
		animation_sprite.play("hurt")

func player_dead():
	if health == 0:
		PlayerDead.emit_signal("PlayerDead")
		
func charge_mana():
	if Input.is_action_pressed("charge"):
		velocity = Vector2.ZERO
		mana += 0.05
		

func player_attack():
	if Input.is_action_just_pressed("attack"):
		AttackSignal.emit_signal("Player_Attack")
		malee_range.disabled = false
		attack_animation.play("claws_attack")
		$Timer.start()


func _on_timer_timeout():
	malee_range.disabled = true
	attack_animation.play("none")


func _on_hitbox_area_entered(area):
	if area.is_in_group("Goblin"):
		enemy_attack_rang = true
	if area.is_in_group("BlackPanther"):
		blackpanther_attack = true


func _on_hitbox_area_exited(area):
	if area.is_in_group("Goblin"):
		enemy_attack_rang = false
	if area.is_in_group("BlackPanther"):
		blackpanther_attack = false


func _on_malee_atk_body_entered(body):
	pass
