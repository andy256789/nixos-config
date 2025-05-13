{
  config.programs.nixvim.plugins.gitsigns = {
    enable = true;
    
    signs = {
      add = {
        text = "│";
        hl = "GitSignsAdd";
      };
      change = {
        text = "│";
        hl = "GitSignsChange";
      };
      delete = {
        text = "_";
        hl = "GitSignsDelete";
      };
      topdelete = {
        text = "‾";
        hl = "GitSignsDelete";
      };
      changedelete = {
        text = "~";
        hl = "GitSignsChange";
      };
    };
    
    signcolumn = true;
    numhl = false;
    linehl = false;
    wordDiff = false;
    
    attachToUntracked = true;
    maxFileLength = 40000;
    
    onAttach.function = ''
      function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gitsigns.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gitsigns.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)
      end
    '';
  };
} 