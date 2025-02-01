-- sdl_window.lua

SDL_WINDOW_RESIZABLE = 0x00000020
SDL_WINDOWPOS_CENTERED = 0x2FFF0000

ffi.cdef[[
	typedef struct SDL_Window SDL_Window;
	SDL_Window* SDL_CreateWindow(const char* title, int x, int y, int w, int h, uint32_t flags);
	void SDL_DestroyWindow(SDL_Window* window);
	void SDL_SetWindowMinimumSize(SDL_Window* window, int min_w, int min_h);
	void SDL_GetWindowSize(SDL_Window* window, int* w, int* h);
]]

sdl.create_window = SDL.SDL_CreateWindow
sdl.destroy_window = SDL.SDL_DestroyWindow
sdl.set_minimum_size = SDL.SDL_SetWindowMinimumSize
sdl.get_window_size = SDL.SDL_GetWindowSize
