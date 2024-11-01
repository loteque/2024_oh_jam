@tool
extends RefCounted
# Create the objects.

func make_scene():
  var node = Node2D.new()
  var body = RigidBody2D.new()
  var collision = CollisionShape2D.new()

  # Create the object hierarchy.
  body.add_child(collision)
  node.add_child(body)

  # Change owner of `body`, but not of `collision`.
  body.owner = node
  var scene = PackedScene.new()

  # Only `node` and `body` are now packed.
  var result = scene.pack(node)
  if result == OK:
    var error = ResourceSaver.save(scene, "res://path/name.tscn")
    if error != OK:
      push_error("An error occurred while saving the scene to disk.")
