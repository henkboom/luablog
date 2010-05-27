local conf = require 'conf'
local plugin = require 'plugin'

plugin.register_element('post_end', function ()
  if conf.disqus_developer then
    print '<script type="text/javascript">var disqus_developer = 1;</script>'
  end

  print([[
    <div id="disqus_thread"></div>
    <script type="text/javascript">
      (function() {
        var dsq = document.createElement('script');
        dsq.type = 'text/javascript';
        dsq.async = true;
        dsq.src =
          'http://]] .. conf.disqus_community_name .. [[.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] ||
         document.getElementsByTagName('body')[0]).appendChild(dsq);
      })();
    </script>
    <noscript>
      Please enable JavaScript to view comments.
    </noscript>
  ]])
end)
