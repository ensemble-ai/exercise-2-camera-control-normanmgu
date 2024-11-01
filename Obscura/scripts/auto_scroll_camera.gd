class_name AutoscrollCamera
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(-5, -5)  # Top-left corner of frame
@export var bottom_right: Vector2 = Vector2(5, 5)  # Bottom-right corner of frame
@export var autoscroll_speed: Vector3 = Vector3(1, 0, 0)  # Units per second to scroll

func _ready() -> void:
	super()
	position = target.position
	rotation_degrees = Vector3(-90, 0, 0)
	draw_camera_logic = true

func _process(delta: float) -> void:
	if !current:
		return
	
	# Move camera by autoscroll amount
	position += autoscroll_speed * delta
	
	# Calculate frame boundaries in world space
	var frame_left = position.x + top_left.x
	var frame_right = position.x + bottom_right.x
	var frame_top = position.z + top_left.y
	var frame_bottom = position.z + bottom_right.y
	
	# Check if player is outside bounds and adjust their position
	if target.position.x < frame_left:
		# Push player if they're touching left boundary
		target.position.x = frame_left
	elif target.position.x > frame_right:
		target.position.x = frame_right
		
	if target.position.z < frame_top:
		target.position.z = frame_top
	elif target.position.z > frame_bottom:
		target.position.z = frame_bottom
	
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
	
	# Draw frame border box
	var top_left_world = Vector3(top_left.x, 0, top_left.y)
	var bottom_right_world = Vector3(bottom_right.x, 0, bottom_right.y)
	
	# Draw the rectangle
	# Top line
	immediate_mesh.surface_add_vertex(Vector3(top_left_world.x, 0, top_left_world.z))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_world.x, 0, top_left_world.z))
	
	# Right line
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_world.x, 0, top_left_world.z))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_world.x, 0, bottom_right_world.z))
	
	# Bottom line
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_world.x, 0, bottom_right_world.z))
	immediate_mesh.surface_add_vertex(Vector3(top_left_world.x, 0, bottom_right_world.z))
	
	# Left line
	immediate_mesh.surface_add_vertex(Vector3(top_left_world.x, 0, bottom_right_world.z))
	immediate_mesh.surface_add_vertex(Vector3(top_left_world.x, 0, top_left_world.z))
	
	immediate_mesh.surface_end()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	await get_tree().process_frame
	mesh_instance.queue_free()
