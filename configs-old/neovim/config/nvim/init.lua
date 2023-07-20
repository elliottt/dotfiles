require 'plugins'
require 'autocommands'
require 'settings'
local mappings = require 'mappings'
require 'lsp'.setup(mappings)
