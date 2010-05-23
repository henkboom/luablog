#!/usr/bin/env lua

local plugin = require 'plugin'
local post = require 'post'

plugin.init()

if os.getenv('QUERY_STRING') == 'atom=1' then
  plugin.page_callback('atom', post.get_posts())
elseif os.getenv('QUERY_STRING'):match('^post=(.+)$') then
  local id = os.getenv('QUERY_STRING'):match('^post=(.+)$')
  local post = post.get_by_id(id)
  if post then
    plugin.page_callback('post', post)
  else
    plugin.page_callback('404')
  end
else
  plugin.page_callback('index')
end
