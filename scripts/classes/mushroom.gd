extends StaticBody2D

@onready var area = $Area2D

func _ready() -> void:
	area.connect("body_entered", self._on_Area2D_body_entered, CONNECT_DEFERRED)

# Function to handle when a body enters the area
func _on_Area2D_body_entered(body):
	print("Player here")
	print(body)
	if body is Player:
		body._high_jump()
