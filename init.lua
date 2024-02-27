if vim.g.vscode then
  require("minimal.setup")
else
  require("config.lazy")
end
