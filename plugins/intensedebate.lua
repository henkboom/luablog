local conf = require 'conf'
local plugin = require 'plugin'

plugin.register_element('post_end', function (post)
  if post.get_meta('no_comments') then
    return
  end

  print([[
    <div id="comments">
      <script>
        var idcomments_acct = ']] .. conf.intensedebate_acct .. [[';
        var idcomments_post_id;
        var idcomments_post_url;
      </script>
      <span id="IDCommentsPostTitle" style="display:none"></span>
      <script type='text/javascript'
              src='http://www.intensedebate.com/js/genericCommentWrapperV2.js'>
      </script>
    </div>
  ]])
end)
