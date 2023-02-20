# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 4}, allow_nil: true

    before_validation :ensure_session_token

    attr_reader :password

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_passwordd?(password)
        b_obj = BCrypt::Password.new(self.password_digest)
        b_obj.is_password?(password)
    end

    def self.find_by_credentials(username, password)

        @user = User.find_by(username: username)

        if @user && @user.is_passwordd?(password)
            return @user
        else
            return nil  
        end

    end


    def reset_session_token!

        self.session_token = generate_unique_session_token
        self.save!
        self.session_token

    end


    private

    def generate_unique_session_token 

        token = SecureRandom.urlsafe_base64

        while User.exists?(session_token: token)
            token = SecureRandom.urlsafe_base64
        end

        return token
    end

    def ensure_session_token

        self.session_token ||= generate_unique_session_token

    end


    
end
