return{
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  opts = {
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj
        lookahead = true,

        keymaps = {
          -- Most standart
          ["af"] = { query = "@function.outer", desc = "Select outer function" },
          ["if"] = { query = "@function.inner", desc = "Select inner function" },
          ["ac"] = { query = "@class.outer", desc = "Select outer class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner class" },
          -- Select return
          ["ar"] = { query = "@return.outer", desc = "Select outer return" },
          ["ir"] = { query = "@return.inner", desc = "Select inner return" },
          -- Select loop
          ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
          ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
          -- Select comment
          ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
          ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },
          -- Statement
          ["am"] = { query = "@statement.outer", desc = "Select outer statement", remap = true },
          -- Scope
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
        -- selection_modes 
        include_surrounding_whitespace = false, -- True broken (select extra non-empty lines)
      },

      -- Swap params
      swap = {
        enable = true,
        swap_next = {
          ["<leader>k"] = { query = "@parameter.inner", desc = "Swap with next param" }
        },
        swap_previous = {
          ["<leader>j"] = { query = "@parameter.inner", desc = "Swap with prev param" },
        },
      },

      -- TODO: make usable
      -- Text object: move
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = { query = "@function.outer", desc = "Next function start" },
          ["]]"] = { query = "@class.outer", desc = "Next class start" },

          ["]l"] = { query = "@loop.outer", desc = "Go to next loop" },
          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
          -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[l"] = { query = "@loop.outer", desc = "Go to prev loop" },
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        -- Below will go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        -- Make it even more gradual by adding multiple queries and regex.
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        }
      },
    },
  }
}
