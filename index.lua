#!/usr/bin/env lua

local view = require 'view'
local post = require 'post'

if os.getenv('QUERY_STRING') == 'atom=1' then
  view.show_atom(post.get_posts())
elseif os.getenv('QUERY_STRING'):match('^post=(.+)$') then
  local id = os.getenv('QUERY_STRING'):match('^post=(.+)$')
  local post = post.get_by_id(id)
  if post then
    view.show_html_post(post)
  else
    view.show_404()
  end
else
  view.show_html_index(post.get_posts())
end
