extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	if isLeft:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
		
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and (event.keycode == KEY_RIGHT or event.keycode == KEY_LEFT):
			sprite_2d.animation = "runnig"
		elif event.pressed and event.keycode == KEY_SPACE:
			sprite_2d.animation = "jump"
		else:
			sprite_2d.animation = "idle"
