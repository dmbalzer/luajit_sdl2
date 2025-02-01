-- sdl_ttf.lua

TTF = ffi.load('SDL2_ttf.dll')
ttf = {}

ffi.cdef[[
	int TTF_Init(void);
	void TTF_Quit(void);
	typedef struct TTF_Font TTF_Font;
	TTF_Font* TTF_OpenFont(const char* file, int ptsize);
	void TTF_CloseFont(TTF_Font* font);
	int TTF_GlyphIsProvided(TTF_Font* font, uint16_t ch);
	SDL_Surface* TTF_RenderGlyph_Blended(TTF_Font* font, uint16_t ch, SDL_Color fg);
	int TTF_SizeUTF8(TTF_Font* font, const char* text, int* w, int* h);
]]

ttf.init = TTF.TTF_Init
ttf.quit = TTF.TTF_Quit
ttf.open_font = TTF.TTF_OpenFont
ttf.close_font = TTF.TTF_CloseFont
ttf.glyph_is_provided = TTF.TTF_GlyphIsProvided
ttf.render_glyph_blended = TTF.TTF_RenderGlyph_Blended
ttf.size_utf8 = TTF.TTF_SizeUTF8
