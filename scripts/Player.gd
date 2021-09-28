extends KinematicBody2D

# ==== VARIABLES ====
const JP = -250 * 60
const GRAV = 10 * 60
var velocity = Vector2()
var speed: float
var runSpeed = 160 * 60
var walkSpeed = 80 * 60
var onLadder = false
export var playerID: int = 1
# var isJumpInterrupted
var endingLabel1
var endingLabel2
var endingButton

func _physics_process(delta):
	if Input.is_action_pressed("sprint" + str(playerID)):
		speed = runSpeed * delta
	else:
		speed = walkSpeed * delta
	
#	# ==== JUMP LIMITER ====
#	isJumpInterrupted = Input.is_action_just_released("moveUp" + str(playerID)) and velocity.y < 0.0
#	if isJumpInterrupted:
#		velocity.y = -20
	
	# ==== MOVEMENT ====
	velocity.x = (Input.get_action_strength("moveRight" + str(playerID)) - Input.get_action_strength("moveLeft" + str(playerID))) * speed
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif Input.is_action_pressed("moveDown" + str(playerID)):
		if is_on_floor():
			$AnimatedSprite.play("crouch")
	else:
		if is_on_floor():
			$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("moveUp" + str(playerID)):
		if is_on_floor():
			velocity.y = JP * delta
	
	# ==== LADDERS & GRAVITY ====
	if onLadder:
		if velocity.x < 0 or velocity.x > 0:
			$AnimatedSprite.play("climb")
		elif Input.is_action_pressed("moveUp" + str(playerID)):
			velocity.y = -speed
			$AnimatedSprite.play("climb")
		elif Input.is_action_pressed("moveDown" + str(playerID)):
			velocity.y = speed
			$AnimatedSprite.play("climb")
		else:
			velocity.y = 0
			$AnimatedSprite.play("climbIdle")
	else:
		velocity.y += GRAV * delta
	
	# ==== JUMPING & FALLING ANIMATION ====
	if not is_on_floor() and not onLadder:
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
	
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, 0.87)
	
	# ==== POSSUM & CHEST ====
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is Possum and is_on_floor() and collision.normal.dot(Vector2.UP) > 0.5:
			velocity.y = JP * delta
			(collision.collider as Possum).playEnemyDeathAnimation()
		elif collision.collider is Possum:
			pass
		elif collision.collider is Chest and is_on_floor() and collision.normal.dot(Vector2.UP) > 0.5:
			(collision.collider as Chest).doChestThings()
			velocity.y = -100 * 60 * delta

# ==== LADDERS ====
func _on_Ladders_body_entered(body):
	if body.name == "Player":
		onLadder = true
func _on_Ladders_body_exited(body):
	if body.name == "Player":
		onLadder = false

# ==== SCORE ====
func addScore(increment):
	UiLayer.score += increment
	get_parent().get_node("/root/UiLayer/HUD/Label").text = str("x ", UiLayer.score)
	
# ==== TELEPORT ====
func _on_GoHome_Button_pressed():
	position.x = 592
	position.y = 96
	endingButton.release_focus()
func _on_EndDetect_body_entered(body):
	if body.name == "Player":
		endingButton.disabled = false
		endingButton.grab_focus()
		endingLabel1.percent_visible = 1
		endingLabel2.percent_visible = 1
func _on_Ending_ready():
	endingLabel1 = get_parent().get_node("Ending/Label")
	endingLabel2 = get_parent().get_node("Ending/Label2")
	endingButton = get_parent().get_node("Ending/GoHome")
	endingLabel1.percent_visible = 0
	endingLabel2.percent_visible = 0
	endingButton.disabled = true
