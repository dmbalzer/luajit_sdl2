-- sdl_event.lua

SDL_TEXTEDITINGEVENT_TEXT_SIZE = 32

ffi.cdef[[
	typedef struct SDL_Keysym
	{
		uint32_t scancode;      /**< SDL physical key code - see SDL_Scancode for details */
		int32_t sym;            /**< SDL virtual key code - see SDL_Keycode for details */
		uint16_t mod;                 /**< current key modifiers */
		uint32_t unused;
	} SDL_Keysym;	

	typedef struct SDL_CommonEvent
	{
		uint32_t type;
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
	} SDL_CommonEvent;

	typedef struct SDL_DisplayEvent
	{
		uint32_t type;        /**< ::SDL_DISPLAYEVENT */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t display;     /**< The associated display index */
		uint8_t event;        /**< ::SDL_DisplayEventID */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
		int32_t data1;       /**< event dependent data */
	} SDL_DisplayEvent;

	typedef struct SDL_WindowEvent
	{
		uint32_t type;        /**< ::SDL_WINDOWEVENT */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The associated window */
		uint8_t event;        /**< ::SDL_WindowEventID */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
		int32_t data1;       /**< event dependent data */
		int32_t data2;       /**< event dependent data */
	} SDL_WindowEvent;

	typedef struct SDL_KeyboardEvent
	{
		uint32_t type;        /**< ::SDL_KEYDOWN or ::SDL_KEYUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The window with keyboard focus, if any */
		uint8_t state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
		uint8_t repeat;       /**< Non-zero if this is a key repeat */
		uint8_t padding2;
		uint8_t padding3;
		SDL_Keysym keysym;  /**< The key that was pressed or released */
	} SDL_KeyboardEvent;

	typedef struct SDL_TextEditingEvent
	{
		uint32_t type;                                /**< ::SDL_TEXTEDITING */
		uint32_t timestamp;                           /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;                            /**< The window with keyboard focus, if any */
		char text[32];  /**< The editing text */
		int32_t start;                               /**< The start cursor of selected editing text */
		int32_t length;                              /**< The length of selected editing text */
	} SDL_TextEditingEvent;

	typedef struct SDL_TextEditingExtEvent
	{
		uint32_t type;                                /**< ::SDL_TEXTEDITING_EXT */
		uint32_t timestamp;                           /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;                            /**< The window with keyboard focus, if any */
		char* text;                                 /**< The editing text, which should be freed with SDL_free(), and will not be NULL */
		int32_t start;                               /**< The start cursor of selected editing text */
		int32_t length;                              /**< The length of selected editing text */
	} SDL_TextEditingExtEvent;

	typedef struct SDL_TextInputEvent
	{
		uint32_t type;                              /**< ::SDL_TEXTINPUT */
		uint32_t timestamp;                         /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;                          /**< The window with keyboard focus, if any */
		char text[32];  /**< The input text */
	} SDL_TextInputEvent;

	typedef struct SDL_MouseMotionEvent
	{
		uint32_t type;        /**< ::SDL_MOUSEMOTION */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The window with mouse focus, if any */
		uint32_t which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
		uint32_t state;       /**< The current button state */
		int32_t x;           /**< X coordinate, relative to window */
		int32_t y;           /**< Y coordinate, relative to window */
		int32_t xrel;        /**< The relative motion in the X direction */
		int32_t yrel;        /**< The relative motion in the Y direction */
	} SDL_MouseMotionEvent;

	typedef struct SDL_MouseButtonEvent
	{
		uint32_t type;        /**< ::SDL_MOUSEBUTTONDOWN or ::SDL_MOUSEBUTTONUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The window with mouse focus, if any */
		uint32_t which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
		uint8_t button;       /**< The mouse button index */
		uint8_t state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
		uint8_t clicks;       /**< 1 for single-click, 2 for double-click, etc. */
		uint8_t padding1;
		int32_t x;           /**< X coordinate, relative to window */
		int32_t y;           /**< Y coordinate, relative to window */
	} SDL_MouseButtonEvent;

	typedef struct SDL_MouseWheelEvent
	{
		uint32_t type;        /**< ::SDL_MOUSEWHEEL */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The window with mouse focus, if any */
		uint32_t which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
		int32_t x;           /**< The amount scrolled horizontally, positive to the right and negative to the left */
		int32_t y;           /**< The amount scrolled vertically, positive away from the user and negative toward the user */
		uint32_t direction;   /**< Set to one of the SDL_MOUSEWHEEL_* defines. When FLIPPED the values in X and Y will be opposite. Multiply by -1 to change them back */
		float preciseX;     /**< The amount scrolled horizontally, positive to the right and negative to the left, with float precision (added in 2.0.18) */
		float preciseY;     /**< The amount scrolled vertically, positive away from the user and negative toward the user, with float precision (added in 2.0.18) */
		int32_t mouseX;      /**< X coordinate, relative to window (added in 2.26.0) */
		int32_t mouseY;      /**< Y coordinate, relative to window (added in 2.26.0) */
	} SDL_MouseWheelEvent;

	typedef struct SDL_JoyAxisEvent
	{
		uint32_t type;        /**< ::SDL_JOYAXISMOTION */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t axis;         /**< The joystick axis index */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
		int16_t value;       /**< The axis value (range: -32768 to 32767) */
		uint16_t padding4;
	} SDL_JoyAxisEvent;

	typedef struct SDL_JoyBallEvent
	{
		uint32_t type;        /**< ::SDL_JOYBALLMOTION */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t ball;         /**< The joystick trackball index */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
		int16_t xrel;        /**< The relative motion in the X direction */
		int16_t yrel;        /**< The relative motion in the Y direction */
	} SDL_JoyBallEvent;

	typedef struct SDL_JoyHatEvent
	{
		uint32_t type;        /**< ::SDL_JOYHATMOTION */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t hat;          /**< The joystick hat index */
		uint8_t value;        /**< The hat position value.
							 *   \sa ::SDL_HAT_LEFTUP ::SDL_HAT_UP ::SDL_HAT_RIGHTUP
							 *   \sa ::SDL_HAT_LEFT ::SDL_HAT_CENTERED ::SDL_HAT_RIGHT
							 *   \sa ::SDL_HAT_LEFTDOWN ::SDL_HAT_DOWN ::SDL_HAT_RIGHTDOWN
							 *
							 *   Note that zero means the POV is centered.
							 */
		uint8_t padding1;
		uint8_t padding2;
	} SDL_JoyHatEvent;

	typedef struct SDL_JoyButtonEvent
	{
		uint32_t type;        /**< ::SDL_JOYBUTTONDOWN or ::SDL_JOYBUTTONUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t button;       /**< The joystick button index */
		uint8_t state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
		uint8_t padding1;
		uint8_t padding2;
	} SDL_JoyButtonEvent;

	typedef struct SDL_JoyDeviceEvent
	{
		uint32_t type;        /**< ::SDL_JOYDEVICEADDED or ::SDL_JOYDEVICEREMOVED */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which;       /**< The joystick device index for the ADDED event, instance id for the REMOVED event */
	} SDL_JoyDeviceEvent;

	typedef struct SDL_JoyBatteryEvent
	{
		uint32_t type;        /**< ::SDL_JOYBATTERYUPDATED */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint32_t level; /**< The joystick battery level */
	} SDL_JoyBatteryEvent;

	typedef struct SDL_ControllerAxisEvent
	{
		uint32_t type;        /**< ::SDL_CONTROLLERAXISMOTION */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t axis;         /**< The controller axis (SDL_GameControllerAxis) */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
		int16_t value;       /**< The axis value (range: -32768 to 32767) */
		uint16_t padding4;
	} SDL_ControllerAxisEvent;

	typedef struct SDL_ControllerButtonEvent
	{
		uint32_t type;        /**< ::SDL_CONTROLLERBUTTONDOWN or ::SDL_CONTROLLERBUTTONUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		uint8_t button;       /**< The controller button (SDL_GameControllerButton) */
		uint8_t state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
		uint8_t padding1;
		uint8_t padding2;
	} SDL_ControllerButtonEvent;

	typedef struct SDL_ControllerDeviceEvent
	{
		uint32_t type;        /**< ::SDL_CONTROLLERDEVICEADDED, ::SDL_CONTROLLERDEVICEREMOVED, ::SDL_CONTROLLERDEVICEREMAPPED, or ::SDL_CONTROLLERSTEAMHANDLEUPDATED */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which;       /**< The joystick device index for the ADDED event, instance id for the REMOVED or REMAPPED event */
	} SDL_ControllerDeviceEvent;

	typedef struct SDL_ControllerTouchpadEvent
	{
		uint32_t type;        /**< ::SDL_CONTROLLERTOUCHPADDOWN or ::SDL_CONTROLLERTOUCHPADMOTION or ::SDL_CONTROLLERTOUCHPADUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		int32_t touchpad;    /**< The index of the touchpad */
		int32_t finger;      /**< The index of the finger on the touchpad */
		float x;            /**< Normalized in the range 0...1 with 0 being on the left */
		float y;            /**< Normalized in the range 0...1 with 0 being at the top */
		float pressure;     /**< Normalized in the range 0...1 */
	} SDL_ControllerTouchpadEvent;

	typedef struct SDL_ControllerSensorEvent
	{
		uint32_t type;        /**< ::SDL_CONTROLLERSENSORUPDATE */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which; /**< The joystick instance id */
		int32_t sensor;      /**< The type of the sensor, one of the values of ::SDL_SensorType */
		float data[3];      /**< Up to 3 values from the sensor, as defined in SDL_sensor.h */
		uint64_t timestamp_us; /**< The timestamp of the sensor reading in microseconds, if the hardware provides this information. */
	} SDL_ControllerSensorEvent;

	typedef struct SDL_AudioDeviceEvent
	{
		uint32_t type;        /**< ::SDL_AUDIODEVICEADDED, or ::SDL_AUDIODEVICEREMOVED */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t which;       /**< The audio device index for the ADDED event (valid until next SDL_GetNumAudioDevices() call), SDL_AudioDeviceID for the REMOVED event */
		uint8_t iscapture;    /**< zero if an output device, non-zero if a capture device. */
		uint8_t padding1;
		uint8_t padding2;
		uint8_t padding3;
	} SDL_AudioDeviceEvent;

	typedef struct SDL_TouchFingerEvent
	{
		uint32_t type;        /**< ::SDL_FINGERMOTION or ::SDL_FINGERDOWN or ::SDL_FINGERUP */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t touchId; /**< The touch device id */
		uint32_t fingerId;
		float x;            /**< Normalized in the range 0...1 */
		float y;            /**< Normalized in the range 0...1 */
		float dx;           /**< Normalized in the range -1...1 */
		float dy;           /**< Normalized in the range -1...1 */
		float pressure;     /**< Normalized in the range 0...1 */
		uint32_t windowID;    /**< The window underneath the finger, if any */
	} SDL_TouchFingerEvent;

	typedef struct SDL_MultiGestureEvent
	{
		uint32_t type;        /**< ::SDL_MULTIGESTURE */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t touchId; /**< The touch device id */
		float dTheta;
		float dDist;
		float x;
		float y;
		uint16_t numFingers;
		uint16_t padding;
	} SDL_MultiGestureEvent;


	typedef struct SDL_DollarGestureEvent
	{
		uint32_t type;        /**< ::SDL_DOLLARGESTURE or ::SDL_DOLLARRECORD */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t touchId; /**< The touch device id */
		uint32_t gestureId;
		uint32_t numFingers;
		float error;
		float x;            /**< Normalized center of gesture */
		float y;            /**< Normalized center of gesture */
	} SDL_DollarGestureEvent;

	typedef struct SDL_DropEvent
	{
		uint32_t type;        /**< ::SDL_DROPBEGIN or ::SDL_DROPFILE or ::SDL_DROPTEXT or ::SDL_DROPCOMPLETE */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		char *file;         /**< The file name, which should be freed with SDL_free(), is NULL on begin/complete */
		uint32_t windowID;    /**< The window that was dropped on, if any */
	} SDL_DropEvent;

	typedef struct SDL_SensorEvent
	{
		uint32_t type;        /**< ::SDL_SENSORUPDATE */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		int32_t which;       /**< The instance ID of the sensor */
		float data[6];      /**< Up to 6 values from the sensor - additional values can be queried using SDL_SensorGetData() */
		uint64_t timestamp_us; /**< The timestamp of the sensor reading in microseconds, if the hardware provides this information. */
	} SDL_SensorEvent;

	typedef struct SDL_QuitEvent
	{
		uint32_t type;        /**< ::SDL_QUIT */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
	} SDL_QuitEvent;

	typedef struct SDL_UserEvent
	{
		uint32_t type;        /**< ::SDL_USEREVENT through ::SDL_LASTEVENT-1 */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		uint32_t windowID;    /**< The associated window if any */
		int32_t code;        /**< User defined event code */
		void *data1;        /**< User defined data pointer */
		void *data2;        /**< User defined data pointer */
	} SDL_UserEvent;


	struct SDL_SysWMmsg;
	typedef struct SDL_SysWMmsg SDL_SysWMmsg;

	typedef struct SDL_SysWMEvent
	{
		uint32_t type;        /**< ::SDL_SYSWMEVENT */
		uint32_t timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
		SDL_SysWMmsg *msg;  /**< driver dependent data, defined in SDL_syswm.h */
	} SDL_SysWMEvent;

	typedef union SDL_Event
	{
		uint32_t type;                          /**< Event type, shared with all events */
		SDL_CommonEvent common;                 /**< Common event data */
		SDL_DisplayEvent display;               /**< Display event data */
		SDL_WindowEvent window;                 /**< Window event data */
		SDL_KeyboardEvent key;                  /**< Keyboard event data */
		SDL_TextEditingEvent edit;              /**< Text editing event data */
		SDL_TextEditingExtEvent editExt;        /**< Extended text editing event data */
		SDL_TextInputEvent text;                /**< Text input event data */
		SDL_MouseMotionEvent motion;            /**< Mouse motion event data */
		SDL_MouseButtonEvent button;            /**< Mouse button event data */
		SDL_MouseWheelEvent wheel;              /**< Mouse wheel event data */
		SDL_JoyAxisEvent jaxis;                 /**< Joystick axis event data */
		SDL_JoyBallEvent jball;                 /**< Joystick ball event data */
		SDL_JoyHatEvent jhat;                   /**< Joystick hat event data */
		SDL_JoyButtonEvent jbutton;             /**< Joystick button event data */
		SDL_JoyDeviceEvent jdevice;             /**< Joystick device change event data */
		SDL_JoyBatteryEvent jbattery;           /**< Joystick battery event data */
		SDL_ControllerAxisEvent caxis;          /**< Game Controller axis event data */
		SDL_ControllerButtonEvent cbutton;      /**< Game Controller button event data */
		SDL_ControllerDeviceEvent cdevice;      /**< Game Controller device event data */
		SDL_ControllerTouchpadEvent ctouchpad;  /**< Game Controller touchpad event data */
		SDL_ControllerSensorEvent csensor;      /**< Game Controller sensor event data */
		SDL_AudioDeviceEvent adevice;           /**< Audio device event data */
		SDL_SensorEvent sensor;                 /**< Sensor event data */
		SDL_QuitEvent quit;                     /**< Quit request event data */
		SDL_UserEvent user;                     /**< Custom event data */
		SDL_SysWMEvent syswm;                   /**< System dependent window event data */
		SDL_TouchFingerEvent tfinger;           /**< Touch finger event data */
		SDL_MultiGestureEvent mgesture;         /**< Gesture event data */
		SDL_DollarGestureEvent dgesture;        /**< Gesture event data */
		SDL_DropEvent drop;                     /**< Drag and drop event data */

		/* This is necessary for ABI compatibility between Visual C++ and GCC.
		   Visual C++ will respect the push pack pragma and use 52 bytes (size of
		   SDL_TextEditingEvent, the largest structure for 32-bit and 64-bit
		   architectures) for this union, and GCC will use the alignment of the
		   largest datatype within the union, which is 8 bytes on 64-bit
		   architectures.

		   So... we'll add padding to force the size to be 56 bytes for both.

		   On architectures where pointers are 16 bytes, this needs rounding up to
		   the next multiple of 16, 64, and on architectures where pointers are
		   even larger the size of SDL_UserEvent will dominate as being 3 pointers.
		*/
		uint8_t padding[sizeof(void *) <= 8 ? 56 : sizeof(void *) == 16 ? 64 : 3 * sizeof(void *)];
	} SDL_Event;

	int SDL_PollEvent(SDL_Event* event);
]]

SDL_QUIT = 0x100

sdl.poll_event = SDL.SDL_PollEvent