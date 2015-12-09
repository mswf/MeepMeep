##Input

Input is used through the input table. There should probably be a nice wrapper for this on the lua side :)

All KeyCodes are SDL_keycodes

#### getMousePosition
```lua
	Input.getMousePosition()
```
Returns two numbers representing the x and y position of the mouse relative to the top left of the game window

#### key
```lua
	Input.key(keyCode)
```
* `keyCode` SDL_KeyCode  
returns wether the key with the given keycode is currently being pressed

#### keyDown
```lua
	Input.keyDown(keyCode)
```
* `keyCode` SDL_KeyCode  
returns wether the key with the given keycode was pressed during the last frame

#### keyUp
```lua
	Input.keyUp(keyCode)
```
* `keyCode` SDL_KeyCode  
returns wether the key with the given keycode was released during the last frame


#### mouseDown
```lua
	Input.mouseDown(button)
```
* `button` int  
returns wether a mouse button has been pressed during the last frame

#### mouseUp
```lua
	Input.mouseUp(button)
```
* `button` int  
returns wether a mouse button has been released during the last frame
