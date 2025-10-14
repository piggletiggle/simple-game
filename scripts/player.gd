extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var num_jumps = 0
@onready var state_chart: StateChart = $StateChart

@onready var _animation_tree: AnimationTree = $AnimationTree
@onready var _animation_state_machine: AnimationNodeStateMachinePlayback = _animation_tree.get("parameters/playback")

@onready var _parent_sprite: Sprite2D = $Sprite2D
var is_on_ground = true
var is_attacking = false

func _input(event):
	is_attacking = event.is_action_pressed("attack")	


func handle_jump():
	if !is_on_floor() and is_on_ground:
		is_on_ground = false
		#state_chart.send_event("jump")
		
	if is_on_floor():
		#num_jumps = 0
		# if we're on the floor, but previous wasn't (i.e. we were in the air)
		if !is_on_ground:
			state_chart.send_event("airToGround")
			is_on_ground = true

func handle_sprite_direction(direction: float):
	for child_sprite in _parent_sprite.get_children():
		var directionToScaleX = (2 * int(direction > 0)) - 1
		_parent_sprite.scale.x = directionToScaleX


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	handle_jump()
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		handle_sprite_direction(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


	# let the state machine know if we are moving or not

	# if velocity.length_squared() <= 0.005:
	# 	_animation_state_machine.travel("Idle")
	# else:
	# 	_animation_state_machine.travel("run")
	# if Input.is_action_just_pressed("attack"):
	# 	is_attacking = true
	# else:
	# 	is_attacking = false

func _on_can_jump_state_physics_processing(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		state_chart.send_event("jump")


func _on_area_2d_hitbox_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		area.take_damage() # TODO
