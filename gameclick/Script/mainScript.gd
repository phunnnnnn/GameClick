extends Control

@onready var main = $"."
@onready var button = $clickButton
@onready var lable = $clicktimeLable
@onready var clock = $clock
@onready var myTimer = $timerContainter/Timer
@onready var bombPowerLable = $bombPowerLable
@onready var clickPerSecLable = $clickPerSecLable
@onready var moneyLable = $moneyLable
@onready var timeLeftLable = $timeLeftLable
@onready var shop = $shop
@onready var timerContainter = $timerContainter
@onready var mousePowerLable = $mousePowerLable
@onready var rerollbutton = $shop/rerollButton
#BOOM
@onready var bomb = $timerContainter/bomb
@onready var prebomb = $timerContainter/prebomb
@onready var bombScaling = $timerContainter/bombScaling

var time = 0.0
var timeLeft = 300.0
var money = 0
var clickAll = 0
var clickedTime = 0
var bombPower = 1
var clickPerMin = 0.0

var mousePower = 1
var mouse_inside = 0

func _ready() -> void:
	button.pressed.connect(_click)
	myTimer.timeout.connect(_clock_update)
	bomb.timeout.connect(_bomb_click)
	prebomb.timeout.connect(_bomb_start)
	bombScaling.timeout.connect(_bomb_power_up)
	#upgradeButton.pressed.connect(_upgrade)
	
	shop.mouse_entered.connect(_shop_enter)
	shop.mouse_exited.connect(_shop_exit)
	#upgradeButton.mouse_entered.connect(_shop_enter)
	#upgradeButton.mouse_exited.connect(_shop_exit)
	
	rerollbutton.pressed.connect(_reroll)
	
	myTimer.start()
	prebomb.start()
	
	#shopsetup
	var upgradeIcon = load("res://Scene/upgradeScene.tscn")
	var instance = upgradeIcon.instantiate()
	shop.add_child(instance)

func _process(delta: float) -> void:
	pass

func _click() :
	clickedTime += mousePower
	clickAll += mousePower
	money += 1
	lable.text = "Clicked %d time" %clickedTime
	moneyLable.text = "Money = %d" %money

func _clock_update() :
	time += 0.1
	timeLeft -= 0.1
	timeLeftLable.text = "Time left >> %.2f" %timeLeft
	clock.text = "TIME >> %.2f" %time
	
	if clickedTime < 0 :
		_gameOver()
	
	if timeLeft < 0.0 :
		_gameOver()
	
	clickPerMin = clickAll/(time)
	clickPerSecLable.text = "Click per Sec >> %.2f" %clickPerMin

func _bomb_start() :
	bomb.start()
	bombScaling.start()
	print("bomb start")

func _bomb_power_up() :
	bombPower += 1
	bombPowerLable.text = "BOMB POWER >> %d" %bombPower
	print("power UP !!!!!")

func _bomb_click() :
	clickedTime -= bombPower
	lable.text = "Clicked %d time" %clickedTime
	print("BOOM")

func _gameOver() :
	print("game over !!")
	get_tree().change_scene_to_file("res://Scene/startScene.tscn")

func _shop_enter() :
	mouse_inside += 1
	_game_pause()
	pass

func _shop_exit() :
	mouse_inside -= 1
	if mouse_inside <= 0 :
		_game_unpause()
	pass

func _game_pause() :
	for child in timerContainter.get_children() :
		if child is Timer :
			child.stop()
	pass

func _game_unpause() :
	for child in timerContainter.get_children() :
		if child is Timer :
			child.start()
	pass

func _reroll() :
	var upgradeIcon = load("res://Scene/upgradeScene.tscn")
	var instance = upgradeIcon.instantiate()
	shop.add_child(instance)
