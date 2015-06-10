class ShorternedUrl < ActiveRecord::Base
  validates :short_url, :uniqueness => true, :presence => true
  validates :submitter_id, :presence => true
  validates :long_url, :presence => true

  def self.random_code
    begin
      code = SecureRandom::urlsafe_base64
    end while ShortenedUrl.exists?(:short_url => code)

    code
  end

  def self.create_for_user_and_long_url(user, long_url)
    short_url = ShortenedUrl.random_code

    ShortenedUrl.new(
      :short_url => short_url,
      :long_url  => long_url,
      :submitter_id = user.id
    )
  end

  def save!
    begin
      short_url = ShorternedUrl.random_code
      super
    rescue ActiveRecord::RecordInvalid
      retry
    end
  end

end
