extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayButton.connect('pressed' , self._playgame)
	$QuitButton.connect('pressed' , self._quitgame)


func _playgame():
	Levelmanager._load_level(1)
	_deactivative_menu()
	
func _quitgame():
	get_tree().quit()
	
func _deactivative_menu() ->void:
	hide()
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)
	
func _activative_menu() ->void:
	show()
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
	
	
