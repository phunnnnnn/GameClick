extends Control

@onready var main = $"."
@onready var readyButton = $Button


func _ready() -> void:
	readyButton.pressed.connect(_gameStart)
	pass

func _process(delta: float) -> void:
	pass

func _gameStart() :
	print("game START ! !! !")
	get_tree().change_scene_to_file("res://Scene/mainScene.tscn")
	pass
