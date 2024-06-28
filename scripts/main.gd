extends Node2D

@export var ava_level: Array[levelData]

@onready var node_2d = $Node2D

func _ready() ->void:
	Levelmanager.main_scene = node_2d
	Levelmanager.levels = ava_level
