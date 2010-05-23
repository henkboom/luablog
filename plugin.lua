local conf = require 'conf'

local page_callbacks = {}
local element_callbacks = {}

local function load_all()
  for _, plugin_name in ipairs(conf.plugins) do
    require('plugins.' .. plugin_name)
  end
end

local function register_page(name, f)
  assert(not page_callbacks[name], 'page collision for "' .. name .. '"')
  page_callbacks[name] = f
end

local function register_element(name, f)
  element_callbacks[name] = element_callbacks[name] or {}
  table.insert(element_callbacks[name], f)
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
  load_all = load_all,
  register_page = register_page,
  register_element = register_element,
  page_callback = page_callback,
  element_callback = element_callback
}
