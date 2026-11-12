[Multiplayer in Godot](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#):
- [High-Level API](https://youtu.be/YnfsyZJRsL8?si=SL4NAdKvs4hjSrnl)
  - sacrificies fine-grained control for ease of use; handling a lot of things behind the scenes
- [Low-Level APi]
  - provides bare metals, rest is up to the dev

### High-level

There's a class interface MultiplayerPeer that abstracts network layers and is inherited by
- ENetMultiplayerPeer
- WebRTCMultiplayerPeer 
- WebSocketMultiplayerPeer (probably what we want to use?)

Every node in Godot has a `multiplayer` property, accessible on each node
- can make MultiplayerAPI object which will override multiplayer for all descendants

To initialize network, create one of the MultiplayerPeer objects, create client or server, and pass it to multiplayer.multiplayer_peer property

See [Example Lobby Implementation](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#example-lobby-implementation)

### Hosting

For hosting the game, I think we can do it in hyades.mit (same place I hosted the soundboard)
- TO DO: script for automatically exporting build to hyades?

While testing, we can just run locally; though we might have to figure out issues with MITnet for connecting over LAN
