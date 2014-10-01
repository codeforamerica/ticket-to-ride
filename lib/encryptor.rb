module Encryptor

  def self.decrypt(data)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    crypt.decrypt_and_verify(data)
  end

  def self.encrypt(data)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    crypt.encrypt_and_sign(data)
  end

end