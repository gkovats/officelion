extends "res://src/Actors/NPC.gd"

class_name Worker

const MOVE_SPEED = 80.0

onready var config = preload("res://src/Actors/Workers/WorkerConfig.gd")

func _init():
	_set_activity(ACTIVITIES.mozy)

func _ready():
	#set_physics_process(false);
	# face random direction
	_facing_rand()
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

func _physics_process(delta):
	if is_on_wall():
		facing *= -1.0
		print('bump' , _velocity.x, facing)
		_do_animation()

	_update_velocity(delta)
	# update velocity
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func _do_animation() -> void:
	var direction = 'left' if  facing == FACING_LEFT else 'right'
	var animation
	match action:
		ACTIONS.idle:
			animation = "idle_" + direction
		ACTIONS.walking:
			animation = "walk_" + direction
		ACTIONS.running:
			animation = "run_" + direction
		ACTIONS.shoved:
			animation = "fall_" + direction
		ACTIONS.getup:
			animation = "getup_" + direction
		_:
			print('???')
	print( 'animation: ', animation )
	if animation && $player.current_animation != animation:
		$player.play(animation)

# When the worker sees the lion
func _on_awareness_entered(body):
	print('Howdy!', name, ' - to - ', body.get_class())
	if 'NPC' == body.get_class():
		return
		if body.action >= ACTIONS.running:
			$speech.say('Why are we running?')
			_update_alarm(ALARM_SCARED)
	if 'Lion' == body.get_class():
		$speech.say('A lion?')
		return
		print('SCARED!')
		facing = FACING_LEFT if position.x < body.position.x else FACING_RIGHT
		_update_alarm(ALARM_SCARED)
	return

# When something enters worker personal space
func _on_hit_region_entered(body):
	if 'Lion' == body.get_class():
		print('SCARED!')
		# face other direction
		facing = FACING_LEFT if position.x < body.position.x else FACING_RIGHT
		_do_activity(ACTIVITIES.shoved)
		$speech.say('Ooof!')
		_update_alarm(ALARM_SCARED)
		# _do_activity(ACTIVITIES.hit)
	return
