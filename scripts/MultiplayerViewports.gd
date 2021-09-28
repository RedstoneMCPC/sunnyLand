extends Node

onready var viewport1 = $HBoxContainer/ViewportContainer1/Viewport1
onready var viewport2 = $HBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $HBoxContainer/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $HBoxContainer/ViewportContainer2/Viewport2/Camera2D
onready var levelSoccer = $HBoxContainer/ViewportContainer2/Viewport2/LevelSoccer

func _ready():
	viewport1.world_2d = viewport2.world_2d
	camera1.target = levelSoccer.get_node("Players/Player1")
	camera2.target = levelSoccer.get_node("Players/Player2")
	levelSoccer.setScoreLabel($Label)
