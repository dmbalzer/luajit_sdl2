-- sdl_image.lua
IMG = ffi.load('SDL2_image.dll')
img = {}

IMG_INIT_JPG    = 0x00000001
IMG_INIT_PNG    = 0x00000002

ffi.cdef[[
	int IMG_Init(int flags);
	void IMG_Quit(void);
	SDL_Texture* IMG_LoadTexture(SDL_Renderer *renderer, const char *file);
	
	typedef struct IMG_Animation {
		int w, h;
		int count;
		SDL_Surface **frames;
		int *delays;
	} IMG_Animation;
	
	IMG_Animation* IMG_LoadAnimation(const char *file);
	void IMG_FreeAnimation(IMG_Animation* anim);
]]

img.init = IMG.IMG_Init
img.quit = IMG.IMG_Quit
img.load_texture = IMG.IMG_LoadTexture
img.load_animation = IMG.IMG_LoadAnimation
img.free_animation = IMG.IMG_FreeAnimation