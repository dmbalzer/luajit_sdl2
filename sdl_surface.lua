-- sdl_surface.lua

ffi.cdef[[
	typedef struct SDL_Palette {
		int ncolors;
		SDL_Color* colors;
		uint32_t version;
		int refcount;
	} SDL_Palette;
	
	typedef struct SDL_BlitMap SDL_BlitMap;
	
	typedef struct SDL_PixelFormat {
		uint32_t format;
		SDL_Palette *palette;
		uint8_t BitsPerPixel;
		uint8_t BytesPerPixel;
		uint8_t padding[2];
		uint32_t Rmask;
		uint32_t Gmask;
		uint32_t Bmask;
		uint32_t Amask;
		uint8_t Rloss;
		uint8_t Gloss;
		uint8_t Bloss;
		uint8_t Aloss;
		uint8_t Rshift;
		uint8_t Gshift;
		uint8_t Bshift;
		uint8_t Ashift;
		int refcount;
		struct SDL_PixelFormat *next;
	} SDL_PixelFormat;
	
	typedef struct SDL_Surface {
		uint32_t flags;
		SDL_PixelFormat *format;
		int w, h;
		int pitch;
		void *pixels;
		void *userdata;
		int locked;
		void *list_blitmap;
		SDL_Rect clip_rect;
		SDL_BlitMap* map;
		int refcount;
	} SDL_Surface;
]]