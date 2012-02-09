class User < ActiveRecord::Base
  has_many :articles
  # after_create :set_writer_role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  ROLES = %w[admin writer editor]

  def other_articles
    if serialized_featured_article_ids
      article_ids = ActiveSupport::JSON.decode(serialized_featured_article_ids)
      Article.where(:user_id => id, :id => article_ids)
    else
      []
    end
  end

  def favorite_sports
    if serialized_favorite_sports
      ActiveSupport::JSON.decode(serialized_favorite_sports)
    else
      []
    end
  end

  def favorite_sports=(category_names)
    self.serialized_favorite_sports = ActiveSupport::JSON.encode(category_names)
  end

  def set_writer_role
    self.roles_mask = 2
    self.save
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum  
  end  
  
  def roles  
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }  
  end  
  
  def role?(role)
    roles.include? role.to_s
  end

  def to_s
    email
  end
end
