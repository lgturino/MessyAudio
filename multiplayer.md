[Multiplayer in Godot](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#):
- [High-Level API](https://youtu.be/YnfsyZJRsL8?si=SL4NAdKvs4hjSrnl)
  - sacrificies fine-grained control for ease of use; handling a lot of things behind the scenes
- [Low-Level API]
  - provides bare metals, rest is up to the dev
- [HTTP Requests](https://docs.godotengine.org/en/stable/tutorials/networking/http_request_class.html)
  - Ideal if making the backend not in Godot, and not making a lot of requests: make an external backend server for the game logic (e.g. FastAPI, such as the soundboard demo used), and just use Godot for making the client communicating with the server via HTTP requests. 

### High-level

There's a class interface MultiplayerPeer that abstracts network layers and is inherited by
- ENetMultiplayerPeer
- WebRTCMultiplayerPeer 
- WebSocketMultiplayerPeer (probably what we want to use for HTML export)

Every node in Godot has a `multiplayer` property, accessible on each node
- can make MultiplayerAPI object which will override multiplayer for all descendants

To initialize network, create one of the MultiplayerPeer objects, create client or server, and pass it to multiplayer.multiplayer_peer property


See [Example Lobby Implementation](https://docs.godotengine.org/en/stable/tutorials/networking/high_level_multiplayer.html#example-lobby-implementation)

Using MultiplayerSyncrhonizer and Spawner for sharing state between client and server: https://ezcha.net/news/5-7-26-multiplayer-in-godot-is-easier-than-you-think

Very nice video explaining high-level API: https://www.youtube.com/watch?v=YnfsyZJRsL8

### Hosting

For hosting the game, I think we can do it in hyades.mit (same place I hosted the soundboard)
- TO DO: script for automatically exporting build to hyades?

While testing, we can just run locally; though we might have to figure out issues with MITnet for connecting over LAN
