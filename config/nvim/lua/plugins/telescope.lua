return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim',{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' } },
  config = function()
    vim.keymap.set("n","<space>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n","<space>en", function ()
      require('telescope.builtin').find_files {
	cwd = "~/home-manager/config/nvim/"
      }
    end)
  end
}
