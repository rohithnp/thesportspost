class User < ActiveRecord::Base
  has_many :articles
  after_create :set_writer_role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  ROLES = %w[admin writer editor]

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
