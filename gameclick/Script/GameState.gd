extends Node

var mousePower = 1

func upgrade_pressed_signal() :
	emit_signal("upgrade_pressed")
	pass

signal upgrade_pressed
