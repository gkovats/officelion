extends Node

const HEAD = 'head'
const FACE = 'face'
const HAIR = 'hair'
const ARM_F = 'arm.f'
const ARM_B = 'arm.b'
const SKIN = 'skin'
const TOP = 'top'
const BOTTOM = 'bottom'
const SKIN_TYPES = [ 0, 1 ]

const TEXTURES = [
	HEAD,
	FACE,
	ARM_B,
	ARM_F,
	TOP,
	BOTTOM
]

# Skin related textures: head, arms
const TEXTURES_SKIN = {
	# pale
	0 : {
		HEAD : preload("res://assets/actors/worker.tall/head.pale.png"),
		ARM_B : preload("res://assets/actors/worker.tall/arm.b.pale.png"),
		ARM_F : preload("res://assets/actors/worker.tall/arm.f.pale.png"),
	},
	# tan
	1 : {
		HEAD : preload("res://assets/actors/worker.tall/head.tan.png"),
		ARM_B : preload("res://assets/actors/worker.tall/arm.b.tan.png"),
		ARM_F : preload("res://assets/actors/worker.tall/arm.f.tan.png"),
	}
}

# hair
const TEXTURES_HAIR = [
	preload("res://assets/actors/worker.tall/hair.blonde.png"),
	preload("res://assets/actors/worker.tall/hair.black.balding.png"),
	preload("res://assets/actors/worker.tall/hair.black.full.png"),
	preload("res://assets/actors/worker.tall/hair.black.short.png"),
	preload("res://assets/actors/worker.tall/hair.brown.balding.png"),
	preload("res://assets/actors/worker.tall/hair.brown.full.png"),
	preload("res://assets/actors/worker.tall/hair.brown.short.png"),
]

const TEXTURES_FACE = [
	preload("res://assets/actors/worker.tall/face.brown.png"),
	preload("res://assets/actors/worker.tall/face.blue.png"),
]

const TEXTURES_TOP = [
	preload("res://assets/actors/worker.tall/top.blue.png"),
	preload("res://assets/actors/worker.tall/top.gray.png"),
	preload("res://assets/actors/worker.tall/top.blue.buttoned.png"),
	preload("res://assets/actors/worker.tall/top.white.buttoned.png"),
]

const TEXTURES_BOTTOM = [
	preload("res://assets/actors/worker.tall/bottom.blacktan.png"),
	preload("res://assets/actors/worker.tall/bottom.brownblack.png"),
]

# get skin textures: head, arm.b, arm.f
static func get_textures() -> Dictionary:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var skin = TEXTURES_SKIN[rng.randi_range(0, 1)]
	var texture = {
		HEAD: skin[HEAD],
		ARM_B: skin[ARM_B],
		ARM_F: skin[ARM_F],
		TOP: TEXTURES_TOP[rng.randi_range(0, TEXTURES_TOP.size() - 1)],
		BOTTOM: TEXTURES_BOTTOM[rng.randi_range(0, TEXTURES_BOTTOM.size() - 1)],
		FACE: TEXTURES_FACE[rng.randi_range(0, TEXTURES_FACE.size() - 1)],
		HAIR: TEXTURES_HAIR[rng.randi_range(0, 3)],
	};
	return texture
