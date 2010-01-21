require 'lfs'

local file_dir = 'files/'

local function read_post(filename)
  local file = assert(io.open(file_dir .. filename))
  local data = file:read('*a')
  file:close()

  local header, content = '', data:match('^\n(.*)$')
  if not (header and content) then
    header, content = data:match('^(.-)\n\n(.*)$')
  end
  if not (header and content) then
    header, content = data:match('^(.*)$'), ''
  end
  if not (header and content) then
    header, content = '', ''
  end

  local metadata = {}
  local success, err = pcall(function ()
    setfenv(assert(loadstring(header or '')), metadata)()
    assert(metadata.title, 'missing post title')
    assert(metadata.date, 'missing post date')
  end)
  if not success then 
    metadata = {
      title = 'Error Loading "' .. filename .. '"',
      date = '2000-01-01T00:00:00Z'
    }
    content = err and '    ' .. err or ''
  end
  return metadata, markdown(content)
end

local function make_post(id)
  local post = {}

  local metadata, content = read_post(id .. '.md')

  function post.get_title()
    return metadata.title
  end

  function post.get_id()
    return id
  end

  function post.get_url()
    return '/' .. id
  end

  function post.get_content()
    return content or ''
  end

  function post.get_date()
    assert(metadata.date)
    return metadata.date
  end

  return post
end

local function get_posts()
  local posts = {}

  for f in lfs.dir(file_dir) do
    local id = f:match('^(%d*)%.md$')
    if id then
      table.insert(posts, make_post(id))
    end
  end

  table.sort(posts, function (a, b)
    if a.get_date() > b.get_date() then
      return true
    elseif a.get_date() < b.get_date() then
      return false
    else
      return a.get_id() > b.get_id()
    end
  end)
  return posts
end

local function get_special(name)
  local file = assert(io.open(file_dir .. '_' .. name .. '.md'))
  local data = file:read('*a')
  file:close()
  return markdown(data)
end

local function get_by_id(id)
  return make_post(id)
end

return { get_posts=get_posts, get_special=get_special, get_by_id=get_by_id }
