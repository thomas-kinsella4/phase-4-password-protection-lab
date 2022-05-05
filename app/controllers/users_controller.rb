class UsersController < ApplicationController
    before_action :authorized, only: [:show]

    def create
        user = User.create(details_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { error: "wrong" }, status: 422
        end
    end

    def show 
        user = User.find_by(id: session[:user_id])
        render json: user
    end

    private 

    def authorized
       return render json: { error: "unauthorized" }, status: :unauthorized unless session.include? :user_id
    end

    def details_params
        params.permit(:username, :password, :password_confirmation)
    end

end
