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

  def save!
    begin
      short_url = ShorternedUrl.random_code
      super
    rescue ActiveRecord::RecordInvalid
      retry
    end
  end

end
