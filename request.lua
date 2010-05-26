local query_string = os.getenv('QUERY_STRING')

local function url_decode(str)
  str = string.gsub (str, "+", " ")
  str = string.gsub (str, "%%(%x%x)",
  function(h) return string.char(tonumber(h,16)) end)
  str = string.gsub (str, "\r\n", "\n")
  return str
end

local get = {}

for pair in string.gmatch(query_string, "[^&]+") do
  local key, val = string.match(pair, "^([^=]*)=(.*)$")
  if key then
    get[key] = url_decode(val)
  end
end

return {
  get=get
}
