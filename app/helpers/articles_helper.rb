module ArticlesHelper
  def format_article(text)
    sanitize(text, :tags => %w(p img br a iframe strong span h1 h2 h3 h4 h5 h6 ol ul li), :attributes => %w(id class style src width height href))
  end
end
