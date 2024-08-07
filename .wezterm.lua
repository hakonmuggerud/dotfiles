local wezterm = require "wezterm"
local config = wezterm.config_builder()

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'META' or 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.96
config.window_decorations = "RESIZE"

config.use_fancy_tab_bar = false
config.colors = {
    tab_bar = {
        background = '#1e1e2e',
        active_tab = {
            bg_color = '#f5c2e7',
            fg_color = '#111111',
        },
    }
}

config.font_size = 16
config.font = wezterm.font({ family = "FiraMono Nerd Font" })
config.bold_brightens_ansi_colors = true
config.font_rules = {
    {
        intensity = "Bold",
        italic = true,
        font = wezterm.font({ family = "Maple Mono", weight = "Bold", style = "Italic" }),
    },
    {
        italic = true,
        intensity = "Half",
        font = wezterm.font({ family = "Maple Mono", weight = "DemiBold", style = "Italic" }),
    },
    {
        italic = true,
        intensity = "Normal",
        font = wezterm.font({ family = "Maple Mono", style = "Italic" }),
    },
}

config.leader = { key = 'e', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
    {
        key = "Backspace",
        mods = "CMD",
        action = wezterm.action.SendString("\x15"),
    },
    {
        key = "-",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' })
    },
    {
        key = "|",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' })
    },
    {
        key = 'h',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection('Left'),
    },
    {
        key = 'l',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection('Right'),
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection('Up'),
    },
    {
        key = 'j',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection('Down'),
    },
    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),
}

return config
