require "markdown"
local post = require 'post'

local blog_url = 'http://localhost/sketch/index.lua'
local atom_url = 'http://localhost/sketch/index.lua?atom=1'

---- HTML ---------------------------------------------------------------------

local html_header = [[
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html><head>
<title>sketch.henk.ca</title>
<link rel="stylesheet" type="text/css" href="layout.css"/>
<link rel="alternate" type="application/atom+xml"
      href="]] .. atom_url .. [["/>
</head><body><div class="content">
]]

local html_footer = [[
</div></body></html>
]]

local function show_html_post(p)
  print(html_header)
  print '<div id="header">'
  print(post.get_special('header').get_content())
  print '</div>'

  print('<div class="post" id="' .. p.get_id() .. '">')
  print('<h2><a href="' .. p.get_url() .. '">' .. p.get_title() .. '</a></h2>')
  print(p.get_content())
  print '</div>\n'

  print '<div id="footer">'
  print(post.get_special('footer').get_content())
  print '</div>'
  print(html_footer)
end

local function show_html_index(posts)
  print(html_header)
  print '<div id="header">'
  print(post.get_special('header').get_content())
  print '</div>'

  for _, p in ipairs(posts) do
    print('<div class="post" id="' .. p.get_id() .. '">')
    print('<h2><a href="' .. p.get_url() .. '">' .. p.get_title() .. '</a></h2>')
    print(p.get_content())
    print '</div>\n'
  end

  print '<div id="footer">'
  print(post.get_special('footer').get_content())
  print '</div>'
  print(html_footer)
end

---- ATOM ---------------------------------------------------------------------

local function show_atom(posts)
  print 'Content-type: application/atom+xml\n'

  print '<?xml version="1.0" encoding="utf-8"?>'
  print '<feed xmlns="http://www.w3.org/2005/Atom">'
  print '<title>sketch.henk.ca</title>'
  print('<link href="' .. atom_url .. '" rel="self"/>')
  print('<link href="' .. blog_url .. '"/>')
  print('<updated>' .. os.date("!%Y-%m-%dT%H:%M:%SZ") .. '</updated>')
  print '<author><name>Henk</name></author>'
  print('<id>' .. atom_url .. '</id>\n')

  for _, p in ipairs(posts) do
    print '<entry>'
    print('<title>' .. p.get_title() .. '</title>')
    print('<link rel="alternate" href="' .. p.get_url() .. '" />')
    print('<id>tag:henk.ca,2009:' .. p.get_id() .. '</id>')
    print('<updated>' .. p.get_date() .. 'T00:00:00Z' .. '</updated>')
    print '<content type="xhtml"><div xmlns="http://www.w3.org/1999/xhtml">'
    print(p.get_content())
    print '</div></content>'
    print '</entry>\n'
  end

  print '</feed>'
end

return {
  show_html_post=show_html_post,
  show_html_index=show_html_index,
  show_atom=show_atom
}
