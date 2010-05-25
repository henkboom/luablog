local conf = require 'conf'
local plugin = require 'plugin'

plugin.register_element('head', function ()
  print('<link rel="openid.server" href="' .. conf.openid_server .. '" />')
  print('<link rel="openid.delegate" href="' .. conf.openid_delegate .. '" />')
  print('<meta http-equiv="X-XRDS-Location" content="' .. conf.openid_xrds ..
        '" />')
end)
