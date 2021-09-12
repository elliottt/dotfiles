require 'plugins'
require 'autocommands'
require 'settings'
require 'ui'
local mappings = require 'mappings'
require 'lsp'.setup(mappings)
require 'treesitter'
