return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- version = "*",
  opts = {
    options = {
      mode = "numbers",
      key = "id",

      -- Filter buffers by cwd path - different projects 
      -- TODO: change filter by tabulation 
      custom_filter = function(buf_number)
        if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
          return true
        end
      end
    },
  },
}
