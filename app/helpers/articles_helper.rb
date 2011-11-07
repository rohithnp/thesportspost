module ArticlesHelper
  def markdown(text)
    sanitize Redcarpet.new(text.strip, :smart, :filter_html).to_html
  end
end
