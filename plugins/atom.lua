local conf = require 'conf'
local plugin = require 'plugin'
local post = require 'post'

local atom_header = [[
Content-type: application/atom+xml

<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
<title>]] .. conf.title .. [[</title>
<link href="]] .. conf.atom_url .. [[" rel="self"/>
<link href="]] .. conf.base_url .. [["/>
<updated>]] .. os.date("!%Y-%m-%dT%H:%M:%SZ") .. [[</updated>
<author><name>]] .. conf.author .. [[</name></author>
<id>]] .. conf.atom_url .. [[</id>
]]

local atom_footer = [[
</feed>
]]

plugin.register_page('atom', function ()
  local posts = post.get_posts()

  print(atom_header)

  for _, p in ipairs(posts) do
    print '<entry>'
    print('<title>' .. p.get_title() .. '</title>')
    print('<link rel="alternate" href="' .. p.get_url() .. '" />')
    print('<id>' .. conf.atom_id_base .. p.get_id() .. '</id>')
    print('<updated>' .. p.get_date() .. 'T00:00:00Z' .. '</updated>')
    print '<content type="xhtml"><div xmlns="http://www.w3.org/1999/xhtml">'
    print(p.get_content())
    print '</div></content>'
    print '</entry>\n'
  end

  print(atom_footer)
end)

plugin.register_element('head', function ()
  print '<link rel="alternate" type="application/atom+xml"'
  print('      href="' .. conf.atom_url .. '"/>')
end)
