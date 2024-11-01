class_name LerpSmoothingCamera
extends CameraControllerBase

@export var follow_speed: float = 10.0  # Speed when vessel is moving
@export var catchup_speed: float = 15.0 # Speed when vessel is stopped
@export var leash_distance: float = 5.0 # Maximum allowed distance from vessel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	position = target.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !current:
		return

	
	# Calculate distance to target
	var distance_to_target = Vector2(target.position.x - position.x,  target.position.z - position.z).length()
	
	# Calculate vessel's current speed
	var vessel_velocity = Vector2(target.velocity.x, target.velocity.z).length()
	var is_vessel_moving = vessel_velocity > 0.1  # Small threshold to detect movement
	
	# Choose which speed to use based on vessel movement
	var current_speed = follow_speed if is_vessel_moving else catchup_speed
	
	# If beyond leash distance, move faster to catch up
	if distance_to_target > leash_distance:
		current_speed = max(current_speed, catchup_speed * 1.5)  # Use faster speed when too far
		
	# Update position with lerp using the determined speed
	position.x = lerp(position.x, target.position.x, current_speed * delta)
	position.z = lerp(position.z, target.position.z, current_speed * delta)
	
	if draw_camera_logic or true:
		draw_logic()
		
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
