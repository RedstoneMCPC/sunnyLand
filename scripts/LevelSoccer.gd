extends Node2D

var player1Position
var player2Position
var ballPosition
var scoreLabel
var scoreLeft: int = 0
var scoreRight: int = 0
var canScore: bool = true

func _ready():
	player1Position = $Players/Player1.position
	player2Position = $Players/Player2.position
	ballPosition = $Ball.position

func setScoreLabel(label):
	scoreLabel = label
	scoreLabel.text = "0 - 0"

func setScore():
	scoreLabel.text = (str(scoreLeft) + " - " + str(scoreRight))

func _on_GoalLeft_body_entered(body):
	if body.name == "Ball":
		if canScore:
			scoreLeft += 1
			setScore()
			canScore = false
			$ScoreTimer.start()

func _on_GoalRight_body_entered(body):
	if body.name == "Ball":
		if canScore:
			scoreRight += 1
			setScore()
			canScore = false
			$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	canScore = true
	reset()

func reset():
#	$Players/Player1.position = player1Position
#	$Players/Player2.position = player2Position
#	$Ball.linear_velocity = Vector2(0, 0)
#	$Ball.angular_velocity = 0
#	$Ball.position = ballPosition
	pass
