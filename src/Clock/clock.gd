extends Node2D

# References to the clock hands
@onready var hour_hand = $HourHand
@onready var minute_hand = $MinuteHand
@onready var second_hand = $SecondHand

var startTime = 9*3600
var endtime = 17*3600
var currentTime = 0
var timeMultiplier = 60

signal  gameTimesUp;
var gameEnded = false;

func _ready():
	# Call the update_time function every frame
	set_process(true)
	update_time(startTime)

func _process(delta):
	update_time(timeMultiplier * delta)
	if(currentTime >= endtime and not gameEnded):
		gameEnded = true
		emit_signal("gameTimesUp")

func update_time(newtime):
	currentTime += newtime
	
	var hours = int(currentTime / 3600)
	var minutes = int((currentTime - hours*3600)/60)
	var seconds = int((currentTime - hours *3600 - minutes * 60))
	
	# Calculate the rotation for each hand
	var second_rotation = deg_to_rad(seconds * 6)  # 360 degrees / 60 seconds
	var minute_rotation = deg_to_rad(minutes * 6 + seconds * 0.1)  # 360 degrees / 60 minutes + seconds influence
	var hour_rotation = deg_to_rad((hours % 12) * 30 + minutes * 0.5)  # 360 degrees / 12 hours + minutes influence
	
	# Apply the rotation
	second_hand.rotation = second_rotation
	minute_hand.rotation = minute_rotation
	hour_hand.rotation = hour_rotation
