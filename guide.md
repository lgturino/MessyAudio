# Using Godot, quick guide

Everything in Godot is a Node, and then there are many other nodes that inherit from other nodes
For example, the inheritence of the Button node is: Button < BaseButton < Control < CanvasItem < Node < Object

You can play around with different nodes to make a node hierarchy
- You can save a node hierarchy as a Godot "Scene" (analogous to "Prefabs" in Unity)
- [Nodes and Scenes](https://docs.godotengine.org/en/stable/getting_started/step_by_step/nodes_and_scenes.html#)
- Then you can [instantiate](https://docs.godotengine.org/en/stable/getting_started/step_by_step/instancing.html) Scenes as nodes of another node hierarchy

Hit F1 to see the class reference, where you can read more about every node

You can also add a GDScript to every node (only 1 script per node)
- by extending the class of the node, you can reference its methods and properties
- you can access a child node by using the get_node() method, or the $ shorthand, e.g. `@onready var sprite = $Sprite2D`

[Signals](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html#) are used to make game objects react to a change in another object without them referencing to each other
- there's built-in signals on classes, e.g. Button has a `pressed()` signal
- to connect signals
  - go to the signal tab (next to inspector) and connect them via the editor, 
  - alternatively use the `connect()` method to connect them in code
- you are also able to create custom signals, and emit them

