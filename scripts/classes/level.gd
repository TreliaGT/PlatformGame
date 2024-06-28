extends Node

class_name Level

@export var level_id: int
@export var spawnpoint: Node2D

var level_data: levelData = null
var level_manager: LevelManager = null

func _ready() -> void:
	if level_manager != null:
		level_data = level_manager._get_level_data_by_id(level_id)
	else:
		print("Level manager is not assigned")
