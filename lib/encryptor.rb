module Encryptor

  def self.decrypt(data)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    if data
      crypt.decrypt_and_verify(data)
    else
      nil
    end
  end

  def self.encrypt(data)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    if data
      crypt.encrypt_and_sign(data)
    else
      nil
    end
  end

end