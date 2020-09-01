extends "res://src/Actors/NPC.gd"

class_name Worker1

const MOVE_SPEED = 80.0

func _ready():
	#set_physics_process(false);
	# face random direction
	_facing_rand()
	_player = get_node("AnimationPlayer")
	_speed = Vector2(MOVE_SPEED, 0)

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

func _on_Area2D_body_entered(body):
	print('Howdy!', name, ' - to - ', body.get_class())
	if 'NPC' == body.get_class():
		if body.state >= STATE_FLEEING:
			_update_alarm(ALARM_SCARED)
		
	if 'Lion' == body.name:
		print('SCARED!')
		_facing = FACING_LEFT if position.x < body.position.x else FACING_RIGHT
		_update_alarm(ALARM_SCARED)
	pass # Replace with function body.
