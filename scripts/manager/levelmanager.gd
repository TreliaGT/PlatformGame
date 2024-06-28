extends Node

class_name LevelManager

@export var levels: Array[levelData]
@export var main_scene: Node2D
var loaded_level: Level = null

# Unload the current level if it exists
func _unload_level() -> void:
	if is_instance_valid(loaded_level):
		loaded_level.queue_free()
	loaded_level = null

# Load a new level by its ID
func _load_level(level_id: int) -> void:
	print("Loading Level...%s" % level_id)
	_unload_level()
	
	var level_data = _get_level_data_by_id(level_id)
	if not level_data:
		return
	
	var level_path = "res://scenes/%s.tscn" % level_data.level_path
	var level_resource = load(level_path)
	
	if level_resource:
		loaded_level = level_resource.instantiate()
		main_scene.add_child(loaded_level)
	else:
		print("Level doesn't exist")

# Get level data by ID
func _get_level_data_by_id(id: int) -> levelData:
	for lvl in levels:
		if lvl.level_id == id:
			return lvl
	return null
