tool
extends Sprite

var pausedShader = false
var time = 0

func _process(delta):
	time += delta
	material.set_shader_param("timeValue", time)

func _set_paused_shader(state):
	pausedShader = state

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Timer.start()

func _on_Area2D_body_exited(body):
	$Timer.stop()
	material.set_shader_param("speed", 1)

func _on_Timer_timeout():
	material.set_shader_param("speed", 100)
