if IsWSL() then
  vim.opt_local.isfname:append('\\')
  vim.bo.includeexpr = "v:lua.WSLpath(v:fname)"
end

