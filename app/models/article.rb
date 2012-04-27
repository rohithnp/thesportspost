class Article < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :category
  belongs_to :subcategory

  before_save :strip_title, :auto_generate_youtube_links
  after_save :add_to_observation_deck

  validates_presence_of :title
  validates_presence_of :text

  friendly_id :title, :use => :slugged

  has_attached_file :image, 
    :styles => {
    :thumb => 'x100',
    :big => '500x500>',
    },
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => "AKIAJEL6CZLKNYXSOD6A",
      :secret_access_key => "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" 
    },
    :path => "/system/:attachment/:id/:style/:filename",   
    :bucket => "thesportspost"
  

  scope :is_live, where('is_draft IS NOT true')

  TYPE_NORMAL = 0
  TYPE_BLOG = 1

  def date_published
    created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%l:%M %p %Z, %B %d, %Y")
  end
  
  def date_published_short
    created_at.in_time_zone('Eastern Time (US & Canada)').strftime("%m/%d/%Y - %l:%M %p %Z")
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

  private
    def strip_title
      self.title = title.strip
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

    def add_to_observation_deck
      if article_type == TYPE_BLOG
        a = ArticleSet.observation_deck
        a.add_article id
        a.save
      end
    end
end
