extends Node2D

const IDLE_DURATION = 1.0
export var moveTo = Vector2()
export var speed = 5
onready var platform = $KinematicBody2D
onready var tween = $Tween

func _ready():
	_init_tween()
	
func _init_tween():
	var duration = moveTo.length() / float(speed * 16)
	tween.interpolate_property(platform, "position", Vector2.ZERO, moveTo, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(platform, "position", moveTo, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()
