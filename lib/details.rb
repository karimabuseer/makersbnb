class Details
  def self.authenticate_password(password)
    if !(password =~ /\d/)
      false
    elsif !(password =~ /[A-Z]/)
      false
    elsif !(password =~ /[a-z]/)
      false
    elsif !(password.length >= 8 && password.length <= 32)
      false
    elsif !(password =~ /[!"%#$%&'()*+]/)
      false
    else
      true
    end
  end

  def self.authenticate_email(email)

    if !(email =~ /[.+@.+\..+]/)
      false
    else
      true
    end
  end

end
