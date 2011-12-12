class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

  before_save :strip_title
  before_save :generate_slug
  before_save :auto_generate_youtube_links

  validates_presence_of :title
  validates_presence_of :text

  default_scope :order => 'created_at DESC'

  has_attached_file :image, :styles => {
    :thumb => 'x100',
    :big => '500x500>'
  }

  def date_published
    created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%l:%M %p %Z, %B %d, %Y")
  end
  
  def date_published_short
    created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%m/%d/%Y - %l:%M %p %Z")
  end

  def auto_generate_youtube_links
    regexes = [
      [ %r{<p>http://youtube\.com/watch\?v=[^<]+</p>}, %r{watch\?v=([^&<]+)} ],
      [ %r{<p>http://youtu\.be/[^<]+</p>}, %r{youtu\.be/([^<]+)} ]
    ]
    regexes.each do |r|
      text.scan(r[0]).each do |link|
        video_id = link.match(r[1])[1]
        self.text.gsub!(link, "<iframe width=\"560\" height=\"315\" src=\"http://www.youtube.com/embed/#{video_id}\" frameborder=\"0\" allowfullscreen></iframe>")
      end
    end
    self.text
  end

  def related_articles
    if serialized_related_article_ids
      ids = ActiveSupport::JSON.decode(serialized_related_article_ids).map {|id| id.to_i }
      Article.where(:id => ids)
    else
      []
    end
  end

  def related_article_ids
    related_articles.map {|a| a.id }
  end

  def related_article_ids=(article_ids)
    self.serialized_related_article_ids = ActiveSupport::JSON.encode(article_ids)
  end

  def same_writer_articles
    if serialized_same_writer_article_ids
      ids = ActiveSupport::JSON.decode(serialized_same_writer_article_ids).map {|id| id.to_i }
      Article.where(:id => ids)
    else
      []
    end
  end

  def same_writer_article_ids
    same_writer_articles.map {|a| a.id }
  end
  
  def same_writer_article_ids=(article_ids)
    self.serialized_same_writer_article_ids = ActiveSupport::JSON.encode(article_ids)
  end

  protected
  def strip_title
    self.title = title.strip
  end

  def generate_slug
    self.slug = title.downcase.gsub(/[^\w ]/,'').gsub(/ +/,'-') + "-#{id}"
  end
end
