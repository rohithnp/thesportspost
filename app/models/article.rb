class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

  has_attached_file :image, :styles => {
    :thumb => 'x100',
    :big => '500x500>'
  }
  before_save :generate_slug
  before_save :auto_generate_youtube_links

  IMAGE_POSITIONS = [
    ['top-left', 0],
    ['top-right', 1],
    # ['mid-left', 2],
    # ['mid-right', 3],
    # ['bottom-left', 4],
    # ['bottom-right', 5]
  ]
  def date_published
    created_at.strftime("%B %d, %Y")
  end

  def auto_generate_youtube_links
    self.text = text
    text.scan(/<p>http:\/\/youtu\.be\/[^<]+<\/p>/).each do |link|
      video_id = link.match('youtu.be\/([^<]+)')[1]
      self.text.gsub!(link, "<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>")
    end
    self.text
  end

  protected
  def generate_slug
    self.slug = title.downcase.gsub(/[^a-z ]/,'').gsub(/ +/,'-') + "-#{id}"
  end
end
