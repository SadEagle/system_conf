-- Hide inside nvim
if os.getenv("NVIM") then
	require("no-status"):setup()
end

-- FIX: error 99% 1 left message annoying
-- Thinking that trouble in yazi itself, because it's wating ending task and think that
require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true })

require("custom-shell"):setup({
    history_path = "default",
    save_history = false,
})

-- Bookmarks plugin
-- TODO: add visualisation key pressing (m and ')
require("bookmarks"):setup({
	persist = "vim",
})
