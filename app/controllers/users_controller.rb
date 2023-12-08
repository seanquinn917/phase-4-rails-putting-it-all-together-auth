class UsersController < ApplicationController


    def create 
      user = User.create(user_params)
        if user_params[:password] != user_params[:password_confirmation]
            render json: { errors: ['Password confirmation foes not match'] }, status: :unprocessable_entity
        elsif user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else 
          render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
          end
    end


    def show
      if session[:user_id].present?
        user= User.find_by(id: session[:user_id])
        render json: {
      id: user.id,
      username: user.username,
      image_url: user.image_url,
      bio: user.bio
    }, status: :created
      else 
        render json: {errors: "Unauthorized"}, status: :unauthorized
    end
  end




private

def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
end
end
