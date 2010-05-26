#!/usr/bin/env lua

local plugin = require 'plugin'
local post = require 'post'
local request = require 'request'

plugin.load_all()

if request.get['atom'] then
  plugin.page_callback('atom', post.get_posts())
elseif request.get['post'] then
  local id = request.get['post'] 
  local post = post.get_by_id(id)
  if post then
    plugin.page_callback('post', post)
  else
    plugin.page_callback('404')
  end
else
  plugin.page_callback('index')
end
