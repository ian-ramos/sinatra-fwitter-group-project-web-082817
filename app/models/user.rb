class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.split("-").join(" "))
  end

  def authenticate(check)
    self.password == check ? self : false
  end

end
