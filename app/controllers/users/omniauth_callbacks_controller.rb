class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # 1) Found on StackOverFlow, supposed to allow CORS access but doesnt
  # protect_from_forgery
  #   after_filter :set_access_control_headers

  # def set_access_control_headers
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Request-Method'] = '*'
  # end

  # 2) Also found on StackOverFlow, supposed to allow CORS access but doesnt
  # headers['Access-Control-Allow-Origin'] = '*'
  # headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  # headers['Access-Control-Request-Method'] = '*'
  # headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  # headers['Access-Control-Allow-Origin'] = 'http://localhost:3000'

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
