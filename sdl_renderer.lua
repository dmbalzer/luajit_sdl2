-- sdl_renderer.lua

SDL_RENDERER_PRESENTVSYNC = 0x00000004
SDL_TEXTUREACCESS_STATIC = 0
SDL_TEXTUREACCESS_STREAMING = 1
SDL_TEXTUREACCESS_TARGET = 2

ffi.cdef[[
	typedef struct SDL_Renderer SDL_Renderer;
	SDL_Renderer* SDL_CreateRenderer(SDL_Window* window, int index, uint32_t flags);
	void SDL_DestroyRenderer(SDL_Renderer* renderer);
	int SDL_SetRenderDrawColor(SDL_Renderer* renderer, uint8_t r, uint8_t g, uint8_t b, uint8_t a);
	int SDL_RenderClear(SDL_Renderer* renderer);
	void SDL_RenderPresent(SDL_Renderer* renderer);
	typedef struct SDL_Texture SDL_Texture;
	void SDL_DestroyTexture(SDL_Texture * texture);
	int SDL_QueryTexture(SDL_Texture* texture, uint32_t* format, int* access, int* w, int* h);
	int SDL_RenderCopy(SDL_Renderer * renderer, SDL_Texture* texture, const SDL_Rect* srcrect, const SDL_Rect* dstrect);
	SDL_Texture * SDL_CreateTexture(SDL_Renderer * renderer, uint32_t format, int access, int w, int h);
	int SDL_UpdateTexture(SDL_Texture * texture, const SDL_Rect * rect, const void *pixels, int pitch);
	typedef enum SDL_TextureAccess
	{
		SDL_TEXTUREACCESS_STATIC,    /**< Changes rarely, not lockable */
		SDL_TEXTUREACCESS_STREAMING, /**< Changes frequently, lockable */
		SDL_TEXTUREACCESS_TARGET     /**< Texture can be used as a render target */
	} SDL_TextureAccess;
	SDL_Texture* SDL_CreateTextureFromSurface(SDL_Renderer* renderer, SDL_Surface* surface);
	int SDL_RenderFillRect(SDL_Renderer* renderer, const SDL_Rect* rect);
]]

sdl.create_renderer = SDL.SDL_CreateRenderer
sdl.destroy_renderer = SDL.SDL_DestroyRenderer
sdl.set_render_draw_color = SDL.SDL_SetRenderDrawColor
sdl.render_clear = SDL.SDL_RenderClear
sdl.render_present = SDL.SDL_RenderPresent
sdl.destroy_texture = SDL.SDL_DestroyTexture
sdl.query_texture = SDL.SDL_QueryTexture
sdl.render_copy = SDL.SDL_RenderCopy
sdl.create_texture = SDL.SDL_CreateTexture
sdl.update_texture = SDL.SDL_UpdateTexture
sdl.create_texture_from_surface = SDL.SDL_CreateTextureFromSurface
sdl.render_fill_rect = SDL.SDL_RenderFillRect
