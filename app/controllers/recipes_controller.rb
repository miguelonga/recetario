class RecipesController < ApplicationController
	before_action :find_receta, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]
	before_filter :check_user, only: [:edit, :update, :destroy]

	def creador
		@recipe = Recipe.all.where(user: current_user).order("created_at DESC")
	end

	def index
		if params[:category].blank?
			@recipe = Recipe.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@recipe = Recipe.where(category_id: @category_id).order("created_at DESC")
		end
	end

	def show
	end	

	def new
		@recipe = current_user.recipes.build  
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)
		@recipe.user_id = current_user.id

		if @recipe.save
			redirect_to @recipe, notice: "Successfully created new recipe"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	def upvote
		@recipe.upvote_by current_user
		redirect_to :back
	end

	private

	def user
		current_user
	end

	def recipe_params
		params.require(:recipe).permit(:title, :description, :user_id, :category_id, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy]) 
	end

	def find_receta
		@recipe = Recipe.find(params[:id])
	end

	def check_user
		if current_user != @recipe.user
			redirect_to root_url, alert: "No puedes modificar una receta que no sea tuya"
		end
	end
end


