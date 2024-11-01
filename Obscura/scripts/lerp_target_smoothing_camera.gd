class_name LerpTargetSmoothingCamera
extends CameraControllerBase

@export var lead_speed: float = 15.0      # Speed to move ahead of player
@export var catchup_speed: float = 15.0   # Speed to return to player
@export var leash_distance: float = 5.0   # Maximum distance from player
@export var catchup_delay_duration: float = 0.25  # Deay before catching up

var time_since_last_movement: float = 0.0
var target_position: Vector3  


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position
	target_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic or true:
		draw_logic()
	
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	var has_moved: bool = input_dir.length_squared() > 0.01
	
	if has_moved:
			# Reset catchup timer when there's input
		time_since_last_movement = 0.0
		
		# Calculate lead target position
		var lead_offset = Vector3(input_dir.x, 0, input_dir.y) * leash_distance
		target_position = target.position + lead_offset
		
		# Move towards lead position
		position = position.lerp(target_position, lead_speed * delta)
	else:
		# print("has not moved")
		time_since_last_movement += delta
		
		# If we've waited long enough, move back to player
		if time_since_last_movement >= catchup_delay_duration:
			target_position = target.position
			position = position.lerp(target_position, catchup_speed * delta)
	

	super(delta)
	
func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# Create the 5 unit cross
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	
	immediate_mesh.surface_end()
	material.shading_mode - BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
