module ArticlesHelper
  def markdown(text)
    RDiscount.new(text, :smart, :filter_html).to_html
  end
end
