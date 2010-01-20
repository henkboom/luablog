require 'lfs'

local file_dir = 'files/'

local function make_post(filename)
  local post = {}

  function post.get_title()
    return filename
  end

  function post.get_id()
    return filename:match('^(.*)%.md$')
  end

  function post.get_url()
    return '/' .. post.get_id()
  end

  function post.get_content()
    local content

    local file = assert(io.open(file_dir .. filename))
    content = (markdown(file:read('*a')))
    file:close()

    return content or ""
  end

  function post.get_date()
    -- heh, this should be changed
    return filename
  end

  return post
end

local function get_posts()
  local posts = {}

  for f in lfs.dir(file_dir) do
    local is_post, _, date = f:find('^(%d*)%.md$')
    if is_post then
      table.insert(posts, make_post(f))
    end
  end

  table.sort(posts, function (a, b) return b.get_date() < a.get_date() end)
  return posts
end

local function get_special(name)
  return make_post('_' .. name .. '.md')
end

local function get_by_id(id)
  return make_post(id .. '.md')
end

return { get_posts=get_posts, get_special=get_special, get_by_id=get_by_id }
