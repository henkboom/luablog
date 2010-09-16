local conf = require 'conf'
local plugin = require 'plugin'
local post = require 'post'

local html = require 'plugins.html'

plugin.register_page('gallery', function ()
  local posts = post.get_posts()

  html.show_html_header()

  print('<div id="gallery">')
  for i = 1, #posts do
    local p = posts[i]
    io.write('<a href="' .. p.get_url() .. '"><img src="' ..
          p.get_url() .. '_thumb.png">' .. '</a>')
  end
  print('</div>')

  html.show_html_footer()
end)
