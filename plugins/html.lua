local conf = require 'conf'
local plugin = require 'plugin'
local post = require 'post'

local html_footer = [[
</div></body></html>
]]

local function show_html_header()
  print 'Content-type: text/html'
  print ''
  print '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"'
  print '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
  print '<html><head>'
  print('<title>' .. conf.title .. '</title>')
  print '<link rel="stylesheet" type="text/css" href="layout.css"/>'
  plugin.element_callback('head')
  print '</head><body><div class="content">'

  print '<div id="header">'
  print(post.get_special('header'))
  print '</div>'
end

local function show_html_footer()
  print '<div id="footer">'
  print(post.get_special('footer'))
  print '</div>'
  print(html_footer)
end

register_page('post', function (post)
  show_html_header()

  print('<div class="post" id="' .. post.get_id() .. '">')
  print('<h2><a href="' .. post.get_url() .. '">' .. post.get_title()
        .. '</a></h2>')
  print(post.get_content())
  print '</div>\n'

  show_html_footer()
end)

register_page('index', function ()
  local posts = post.get_posts()

  show_html_header()

  for _, p in ipairs(posts) do
    print('<div class="post" id="' .. p.get_id() .. '">')
    print('<h2><a href="' .. p.get_url() .. '">' .. p.get_title() .. '</a></h2>')
    print(p.get_content())
    print '</div>\n'
  end

  show_html_footer()
end)

register_page('404', function ()
  print('Status: 404 Not Found')
  show_html_header()

  print '<div class="post" id="error">'
  print '<h2>404 Not Found</h2>'
  print '</div>\n'

  show_html_footer()
end)
