extends CanvasLayer

@onready var colorRect = $ColorRect
@onready var animationPlayer = $AnimationPlayer

signal onTransitionFinished

func _ready():
	colorRect.visible = false
	animationPlayer.animation_finished.connect(animationFinishedPlaying)

func transition():
	colorRect.visible = true
	animationPlayer.play("fading")

func animationFinishedPlaying(animationName):
	if animationName == 'fading':
		animationPlayer.play("fadingToNormal")
		onTransitionFinished.emit()
	elif  animationName == 'fadingToNormal':
		colorRect.visible = false
