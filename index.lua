#!/usr/bin/env lua

local conf = require 'conf'
local plugin = require 'plugin'
local post = require 'post'
local request = require 'request'

plugin.load_all()

if request.get['post'] then
  local id = request.get['post'] 
  local post = post.get_by_id(id)
  if post then
    plugin.page_callback('post', post)
  else
    plugin.page_callback('404')
  end
else
  local page = request.get['page'] or conf.default_page
  plugin.page_callback(page, post.get_posts())
end
