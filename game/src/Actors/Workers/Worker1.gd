extends "res://src/Actors/NPC.gd"

class_name Worker1

const MOVE_SPEED = 80.0

onready var speech = get_node("Speech")

onready var config = preload("res://src/Actors/Workers/WorkerConfig.gd")

func _ready():
	#set_physics_process(false);
	# face random direction
	_facing_rand()
	_player = get_node("AnimationPlayer")
	_speed = Vector2(MOVE_SPEED, 0)
	var textures = config.get_textures()
	$hair.texture = textures[config.HAIR]
	$head.texture = textures[config.HEAD]
	$arm_b.texture = textures[config.ARM_B]
	$arm_f.texture = textures[config.ARM_F]
	$face.texture = textures[config.FACE]
	$bottom.texture = textures[config.BOTTOM]
	$top.texture = textures[config.TOP]
	$top.modulate = Color(rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0))
	$bottom.modulate = Color(rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0), rng.randf_range(0.8, 1.0))
	# $head.modulate = Color(0.8, 0.65, 0.35)
	
	# var mod = Color(0.3, 0.18, 0.15)
	# $head.modulate = mod
	# $arm_b.modulate = mod
	# $arm_f.modulate = mod
	# $hair.modulate = mod
	pass

func _physics_process(delta):
	if is_on_wall():
		_facing *= -1.0
		print('bump' , _velocity.x, _facing)

	# update velocity
	_update_velocity(delta)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

	var direction = 'left' if  _facing == FACING_LEFT else 'right'
	match state:
		STATE_IDLE:
			_player.play("idle_" + direction)
		STATE_WALKING:
			_player.play("walk_" + direction)
		STATE_FLEEING:
			_player.play("run_" + direction)

# When the worker sees the lion
func _on_awareness_entered(body):
	print('Howdy!', name, ' - to - ', body.get_class())
	if 'NPC' == body.get_class():
		return
		if body.state >= STATE_FLEEING:
			speech.say('Why are we running?')
			_update_alarm(ALARM_SCARED)
	if 'Lion' == body.get_class():
		speech.say('A lion?')
		return
		print('SCARED!')
		_facing = FACING_LEFT if position.x < body.position.x else FACING_RIGHT
		_update_alarm(ALARM_SCARED)
	return

# When something enters worker personal space
func _on_personal_bubble_entered(body):
	if 'Lion' == body.get_class():
		print('SCARED!')
		_facing = FACING_LEFT if position.x < body.position.x else FACING_RIGHT
		_update_alarm(ALARM_SCARED)
	return
