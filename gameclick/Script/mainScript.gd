extends Control

@onready var main = $"."
@onready var button = $clickButton
@onready var lable = $clicktimeLable
@onready var clock = $clock
@onready var myTimer = $Timer
#BOOM
@onready var bomb = $bomb
@onready var prebomb = $prebomb
@onready var bombScaling = $bombScaling


var clickedTime = 0
var time = 0.0
var bombPower = 1

func _ready() -> void:
	button.pressed.connect(_click)
	myTimer.timeout.connect(_clock_update)
	bomb.timeout.connect(_bomb_click)
	prebomb.timeout.connect(_bomb_start)
	bombScaling.timeout.connect(_bomb_power_up)
	myTimer.start()
	prebomb.start()

func _process(delta: float) -> void:
	pass

func _click() :
	clickedTime += 1
	lable.text = "Clicked %d time" %clickedTime

func _clock_update() :
	time += 0.1
	clock.text = "TIME >> %f" %time

func _bomb_start() :
	bomb.start()
	bombScaling.start()
	print("bomb start")

func _bomb_power_up() :
	bombPower += 1
	print("power UP !!!!!")

func _bomb_click() :
	clickedTime -= bombPower
	lable.text = "Clicked %d time" %clickedTime
	print("BOOM")
