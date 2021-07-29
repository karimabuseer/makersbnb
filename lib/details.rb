class Details
  def self.authenticate_password(password)
    
    if !(password =~ /\d/)
      return false
    elsif !(password =~ /[A-Z]/)
      return false
    elsif !(password =~ /[a-z]/)
      return false
    elsif !(password.length >=8 && password.length <= 32)
      return false
    elsif !(password =~ /[!"%#$%&'()*+]/)
      return false
    else
      return true
    end
  end
end