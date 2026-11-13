-- ~/.config/hypr/hyprland.lua
-- Converted from hyprland.conf for Hyprland 0.55+
-- Ref: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
hl.monitor({
    output = "DP-2",
    mode = "highrr",   -- highest refresh rate, highest quality
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "second-monitor",
    mode = "1920x1080@60",
    position = "1920x0",
    scale = 1,
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- Nvidia env variables
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
hl.env("WLR_DRM_NO_ATOMIC", "1")

-- Hyprcursor
hl.env("HYPRCURSOR_THEME", "")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "21")
hl.env("GTK_CURSOR_THEME", "Bibata-Modern-Classic")

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("hyprpaper")
    -- Quickshell: ~/.config/quickshell/shell.qml is the 'default' config, so it
    -- is started with no -c flag (that dir holds shell.qml, so quickshell ignores
    -- subdirectories). shell.qml loads Bar / Launcher / Clipboard / Notification /
    -- WallpaperPicker / DesktopWidgets, so one process covers the whole bar.
    hl.exec_cmd("qs -d")
    hl.exec_cmd("xdg-desktop-portal")
    hl.exec_cmd("udiskie --automount --no-notify")
    hl.exec_cmd("/usr/libexec/xdg-desktop-portal-hyprland")
    hl.exec_cmd("xdg-desktop-portal-wlr")
    hl.exec_cmd("hypridle")
    -- Audio handled by systemd (pipewire/wireplumber/pipewire-pulse)
    -- (not recommended on systemd):
    -- hl.exec_cmd("pipewire")
    -- hl.exec_cmd("wireplumber")
    -- hl.exec_cmd("pipewire-pulse")
    hl.exec_cmd("wl-paste --watch cliphist store")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    input = {
        kb_layout = "us,ir",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = true,
        repeat_rate = 50,
        repeat_delay = 300,
        touchpad = {
            natural_scroll = true, -- no touchpad, kept from original anyway
        },
    },

    general = {
        gaps_in = 8,
        gaps_out = 2,
        border_size = 2,
        col = {
            active_border = "rgba(d0d0d0cc)",
            inactive_border = "rgba(00000033)",
        },
        layout = "dwindle",
        -- keep this on, it's for games! less latency and jitter in games
        allow_tearing = true,
    },

    dwindle = {
        preserve_split = true,
        smart_split = false,
        smart_resizing = true,
    },

    xwayland = {
        enabled = true,
    },

    decoration = {
        rounding = 15,
        blur = {
            enabled = true,
            ignore_opacity = true,
            size = 6,
            passes = 2,
            popups = true,
        },
        shadow = {
            enabled = true,
            range = 20,
            render_power = 4,
            color = "rgba(00000055)",
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        vrr = 0,
        -- vfr = true,
    },

    debug = {
        damage_tracking = true,
    },
})

-- Curves
hl.curve("expressiveFastSpatial",    { type = "bezier", points = { {0.42, 1.67}, {0.21, 0.90} } })
hl.curve("expressiveSlowSpatial",    { type = "bezier", points = { {0.39, 1.29}, {0.35, 0.98} } })
hl.curve("expressiveDefaultSpatial", { type = "bezier", points = { {0.38, 1.21}, {0.22, 1.00} } })
hl.curve("emphasizedDecel",          { type = "bezier", points = { {0.05, 0.7},  {0.2, 1} } })
hl.curve("emphasizedAccel",          { type = "bezier", points = { {0.3, 0},    {0.8, 0.15} } })
hl.curve("standardDecel",            { type = "bezier", points = { {0, 0},      {0, 1} } })
hl.curve("menu_decel",               { type = "bezier", points = { {0.1, 1},    {0, 1} } })
hl.curve("overshoot",                { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })
hl.curve("menu_accel",               { type = "bezier", points = { {0.52, 0.03},{0.72, 0.08} } })
hl.curve("stall",                    { type = "bezier", points = { {1, -0.1},   {0.7, 0.85} } })

-- Windows
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 5,   bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 3,   bezier = "emphasizedDecel" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2,   bezier = "emphasizedDecel", style = "popin 90%" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2,   bezier = "emphasizedDecel" })
hl.animation({ leaf = "windows",    enabled = true, speed = 5,   bezier = "emphasizedDecel", style = "slide" }) -- windowsMove
hl.animation({ leaf = "border",     enabled = true, speed = 10,  bezier = "emphasizedDecel" })

-- Layers
hl.animation({ leaf = "layersIn",  enabled = true, speed = 5, bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 4, bezier = "menu_accel",       style = "popin 80%" })

-- Fade
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 5, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 5, bezier = "stall" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })

-- Special workspace
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 2.8, bezier = "emphasizedDecel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 1.2, bezier = "emphasizedAccel", style = "slidevert" })

-----------------------
---- WINDOW RULES -----
-----------------------
-- I hate lua this is shit
hl.window_rule({ name = "opacity-kitty",    match = { class = "kitty" },              opacity = "0.8 0.6" })
hl.window_rule({ name = "opacity-spotify",  match = { class = "Spotify" },            opacity = "0.7 0.6" })
hl.window_rule({ name = "opacity-discord",  match = { class = "discord" },            opacity = "0.8 0.7" })
hl.window_rule({ name = "opacity-chromium", match = { class = "chromium" },           opacity = "0.8 0.7" })
hl.window_rule({ name = "opacity-steam",    match = { class = "steam" },              opacity = "0.8 0.7" })
hl.window_rule({ name = "opacity-codium",   match = { class = "codium" },             opacity = "0.8 0.6" })
hl.window_rule({ name = "opacity-dolphin",  match = { class = "org.kde.dolphin" },    opacity = "0.8 0.7" })
hl.window_rule({ name = "opacity-telegram", match = { class = "org.telegram.desktop" }, opacity = "0.8 0.7" })
hl.window_rule({ name = "opacity-ts3",      match = { class = "TeamSpeak 3" },        opacity = "0.8 0.5" })
hl.window_rule({ name = "opacity-element",  match = { class = "Element" },            opacity = "0.8 0.6" })
---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- NOTE: "fullscreen" dispatcher name wasn't shown in the official example config so hopefully 
-- this works
-- Update : IT DOES yippie 
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("qs ipc call launcher toggle"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("quickshell -p ~/.config/quickshell/Lock.qml"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("qs ipc call clipboard toggle"))
-- Wallpaper toggle 
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("bash wall"))

-- Quickshell bar toggle
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("pkill -x qs || pkill -x quickshell || qs -d"))

-- Move focus with vim keys
hl.bind(mainMod .. " + ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.focus({ direction = "right" }))

-- Audio binds
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("playerctl -p spotify play-pause"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("playerctl -p spotify next"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("playerctl -p spotify previous"))

-- Second monitor virtual toggle 
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("~/.local/bin/toggle-second-monitor"))
-- Workspace binds
for i = 1, 8 do
    local key = i % 9 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Special workspace binds
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.workspace.toggle_special())

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
