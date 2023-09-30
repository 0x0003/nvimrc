local present, ua = pcall(require, 'ultimate-autopair')

if not present then
  return
end

ua.setup({})

vim.api.nvim_create_user_command('AutopairToggle', function()
  ua.toggle()
end, {})

