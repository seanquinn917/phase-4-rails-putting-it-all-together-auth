class RecipesController < ApplicationController

    def index
        if session[:user_id]
          recipes = Recipe.all
          if recipes.any?
            render json: recipes, include: :user
          else
            render json: { errors: ["Unauthorized"] }, status: :unauthorized
          end
        else
          render json: { errors: ["Unauthorized"] }, status: :unauthorized
        end
      end
    
      def create
        if session[:user_id]
            recipe= Recipe.create(recipe_params)
            recipe.user_id = session[:user_id]
        if recipe.save
            render json: recipe, include: :user, status: :created
        else !session[:user_id]
            render json: {errors: [recipe.errors.full_messages]}, status: :unprocessable_entity
        end
        else 
            render json: {errors: ["Unauthorized"] }, status: :unauthorized
        end
    end 


      private

      def recipe_params
        params.permit(:id, :title, :instructions, :minutes_to_complete)
      end



end
