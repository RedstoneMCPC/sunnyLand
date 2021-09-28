extends CanvasLayer

var score = 0

# ==== DEFAULTS ====
func _ready():
	$LevelSelect.hide()
	$OptionsMenu.hide()
	$PauseMenu.hide()
	$MainMenu.show()
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()
	AudioServer.set_bus_volume_db(1, 0.5)
	$OptionsMenu/CenterContainer/HBoxContainer/VBoxContainer/HSlider.value = 0.5
	$OptionsMenu/CenterContainer/HBoxContainer/VBoxContainer/HSlider.value = 0.5

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $LevelSelect.visible == false and $OptionsMenu.visible == false and $MainMenu.visible == false:
			if $PauseMenu.visible == true:
				$PauseMenu.hide()
				get_tree().paused = false
			else:
				$PauseMenu.show()
				$PauseMenu/CenterContainer/VBoxContainer/LevelExit.grab_focus()
				$PauseMenu/CenterContainer/VBoxContainer/MenuVolume.value = db2linear(AudioServer.get_bus_volume_db(1))
				get_tree().paused = true

# ==== MAIN MENU ====
func _on_LevelSelect_pressed():
	$LevelSelect.show()
	$MainMenu.hide()
	$LevelSelect/HBoxContainer/VBoxContainer/Level01.grab_focus()

func _on_Options_pressed():
	$OptionsMenu.show()
	$OptionsMenu/CenterContainer/HBoxContainer/VBoxContainer/HSlider.value = db2linear(AudioServer.get_bus_volume_db(1))
	$MainMenu.hide()
	$OptionsMenu/CenterContainer/HBoxContainer/VBoxContainer/Back.grab_focus()

func _on_About_pressed():
	$MainMenu.hide()
	$AboutMenu.show()
	$AboutMenu/HBoxContainer/VBoxContainer/Button.grab_focus()

func _on_Credits_pressed():
	$MainMenu.hide()
	$Credits.show()
	$Credits/HBoxContainer/VBoxContainer/CreditBack.grab_focus()

func _on_Exit_pressed():
	get_tree().quit()

# ==== LEVEL SELECT ====
func _on_Level01_pressed():
	$LevelSelect.hide()
	$HUD.show()
	get_tree().change_scene("res://scenes/Level01.tscn")
	get_tree().paused = false

func _on_LevelSoccer_pressed():
	$LevelSelect.hide()
	get_tree().change_scene("res://scenes/MultiplayerViewports.tscn")
	get_tree().paused = false

func _on_BackButton_pressed():
	$LevelSelect.hide()
	$MainMenu.show()
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()

# ==== OPTIONS MENU ====
func _on_Back_pressed():
	$OptionsMenu.hide()
	$MainMenu.show()
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()

func _on_HSlider_value_changed(value):
	value = linear2db(value)
	AudioServer.set_bus_volume_db(1, value)

# ==== PAUSE MENU ====
func _on_MenuVolume_value_changed(value):
	value = linear2db(value)
	AudioServer.set_bus_volume_db(1, value)

func _on_LevelExit_pressed():
	$PauseMenu.hide()
	$HUD.hide()
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	$MainMenu.show()
	score = 0
	$HUD/Label.text = str("x ", score)
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()

# ==== ABOUT & CREDIT PAGE ====
func _on_Button_pressed():
	$AboutMenu.hide()
	$MainMenu.show()
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()

func _on_CreditBack_pressed():
	$Credits.hide()
	$MainMenu.show()
	$MainMenu/HBoxContainer/VBoxContainer/LevelSelect.grab_focus()
