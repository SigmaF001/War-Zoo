extends Control

@export var skill_cooldown : PackedScene

func _ready():
	SignalBus.connect("TranformCooldown", tranform_skill_cooldown)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tranform_skill_cooldown(node : Node):
	var label_instance : Label = skill_cooldown.instantiate()
	node.add_child(label_instance)
	print("Cooldown")
