module Devise
  module Strategies
    class CustomStrategy < Authenticatable
      def authenticate!
        begin
          return fail! "Invalid email or secret" unless valid_request? params[:user]
          user = User.find_by!(email: params[:user][:email])
          secret = Secret.find_by!(encrypted_secret:  params[:user][:secret], user_id: user.id)
          success! user        
        rescue ActiveRecord::RecordNotFound
          fail! "Invalid email or code secret"
        rescue
          fail! "Some error occured. Please try later"  
        end  
      end

      private
      
      def valid_request? payload
        payload[:email] && payload[:secret]
      end
    end
  end
end

Warden::Strategies.add(:custom_authenticable, Devise::Strategies::CustomStrategy)
