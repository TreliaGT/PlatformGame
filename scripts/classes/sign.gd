extends Area2D

@export var description: String

@onready var label = $Control/TextureRect/Label
@onready var tooltip = $Control
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(description)


func _on_body_entered(body):
	if body is Player:
		print("Enter")
		tooltip.visible = true
		await get_tree().create_timer(5).timeout
		tooltip.visible = false

