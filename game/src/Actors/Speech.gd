extends Node2D

var text = ''
var text_index = 0
var current_text = ''
var display_timeout = 5.0

onready var label = get_node("VBoxContainer/Label")
onready var ninerect = get_node("VBoxContainer/Label/NinePatchRect")
onready var timer = get_node("Timer")

var do_close = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect('timeout', self, '_update_text')
	_reset()
	pass # Replace with function body.

func say(something: String, timeout: float = 5.0):
	_reset()
	text = something
	display_timeout = timeout
	_update_text()
	
func _reset():
	timer.stop()
	text_index = 0
	label.text = ''
	current_text = ''
	label.set_anchors_preset(Control.PRESET_WIDE)
	label.visible = false
	do_close = false

func _update_text():
	if (!do_close):
		if (!label.visible):
			label.visible = true
		current_text += text[text_index]
		label.text = current_text
		text_index += 1
		
		if(text_index < text.length()):
			timer.start(0.01)
		else:
			if (!do_close):
				do_close = true
				timer.start(display_timeout)
	else:
		_reset()
	return
