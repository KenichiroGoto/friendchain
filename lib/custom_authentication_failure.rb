class CustomAuthenticationFailure < Devise::FailureApp
protected
  def redirect_url
    root_path
  end

  # def respond
  #   if http_auth?
  #     http_auth
  #   else
  #     redirect_to root_url
  #   end
  # end

end
