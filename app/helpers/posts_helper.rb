module PostsHelper
  # This isn't strictly correct, but it's a pretty good guess
  # and saves another hit to the DB
  def more_content?
    @posts.size == Post::DEFAULT_LIMIT
  end

  def disqus_comments
    developer_mode = <<-ENDD
    <script 'text/javascript'>
      var disqus_developer = 1;
    </script>
    ENDD
    disqus_output = <<-END
    <div id='disqus_thread'></div>
      <script src='http://disqus.com/forums/rubyonrio/embed.js' type='text/javascript'></script>
      <noscript>
        <a href='http://rubyonrio.disqus.com/?url=ref'>View the discussion thread</a>
      </noscript>
      <a class='dsq-brlink' href='http://disqus.com'>blog comments powered by <span class="logo-disqus">Disqus</span></a>
    </div>
    END
    output = developer_mode + disqus_output unless Rails.env == 'production'
    output = disqus_output if Rails.env == 'production'
    output.html_safe
  end
end
