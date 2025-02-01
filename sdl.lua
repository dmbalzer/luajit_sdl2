-- sdl.lua
ffi = require 'ffi'
SDL = ffi.load('SDL2.dll')
sdl = {}

SDL_INIT_VIDEO = 0x20

ffi.cdef[[
	int SDL_Init(uint32_t flags);
	void SDL_Quit(void);
	const char* SDL_GetError(void);
	uint32_t SDL_GetTicks(void);

	typedef struct SDL_Rect
	{
		int x, y;
		int w, h;
	} SDL_Rect;
	
	typedef struct SDL_Color
	{
		uint8_t r;
		uint8_t g;
		uint8_t b;
		uint8_t a;
	} SDL_Color;
]]

sdl.init = SDL.SDL_Init
sdl.quit = SDL.SDL_Quit
sdl.get_error = SDL.SDL_GetError
sdl.get_ticks = SDL.SDL_GetTicks

require 'sdl_events'
require 'sdl_window'
require 'sdl_surface'
require 'sdl_renderer'
