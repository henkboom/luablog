local conf = require 'conf'

local page_callbacks = {}
local element_callbacks = {}

---- plugin environment -------------------------------------------------------

local plugin_env = setmetatable({}, {__index = _G})

function plugin_env.register_page(name, f)
  assert(not page_callbacks[name], 'page collision for "' .. name .. '"')
  page_callbacks[name] = f
end

function plugin_env.register_element(name, f)
  element_callbacks[name] = element_callbacks[name] or {}
  table.insert(element_callbacks[name], f)
end

---- plugin handling ----------------------------------------------------------

local function init()
  for _, plugin_name in ipairs(conf.plugins) do
    local plugin_init = assert(loadfile('plugins/' .. plugin_name .. '.lua'))
    setfenv(plugin_init, plugin_env)
    plugin_init()
  end
end

local function page_callback(callback_name, ...)
  page_callbacks[callback_name](...)
end

local function element_callback(callback_name, ...)
  for _, f in ipairs(element_callbacks[callback_name] or {}) do
    f(...)
  end
end

return {
  init = init,
  page_callback = page_callback,
  element_callback = element_callback
}
