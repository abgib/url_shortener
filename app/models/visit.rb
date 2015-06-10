class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :url_id, :presence => true

  def self.record_visit!(user, shortened_url)
    Visit.new(
      :user_id => user.id,
      :url_id  => shortened_url.id
    )
  end
end
