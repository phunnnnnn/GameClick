extends Control
@onready var main = $"."
@onready var upgradeButton = $Button

func _ready() -> void:
	upgradeButton.pressed.connect(_on_pressed)
	upgradeButton.mouse_entered.connect(_enter_button)
	upgradeButton.mouse_exited.connect(_exit_button)

func _process(delta: float) -> void:
	pass

func _on_pressed() :
	print("Upgrade yay")
	main.queue_free()
	GameState.mousePower += 1
	GameState.upgrade_pressed_signal()
	pass


func _enter_button() :
	#print("ssss")
	pass
func _exit_button() :
	#print("dddd")
	pass
