class RecipesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def index
      @recipes = current_user.recipes
      @show_new_recipe_button = true
  end

  def public_recipes
    @recipes = Recipe.where(public: true)
    @show_new_recipe_button = false
    render :index
  end

  def show
    @recipe = Recipe.find(params[:id])
    @show_buttons = @recipe.user == current_user
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
  
    if params[:recipe][:images].present?
      @recipe.images.attach(params[:recipe][:images])
    end
  
    if params[:recipe][:videos].present?
      @recipe.videos.attach(params[:recipe][:videos])
    end
  
    if params[:recipe][:audios].present?
      @recipe.audios.attach(params[:recipe][:audios])
    end
  
    if params[:recipe][:documents].present?
      @recipe.documents.attach(params[:recipe][:documents])
    end

    if @recipe.update(recipe_params.except(:images, :videos, :audios, :documents))
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  def destroy_attachment
    @recipe = Recipe.find(params[:id])
    attachment_type = params[:attachment_type]
    attachment_id = params[:attachment_id]

    if attachment_type && attachment_id
      attachment = @recipe.send(attachment_type).find_by(id: attachment_id)
      if attachment
        attachment.purge
        redirect_to @recipe, notice: "#{attachment_type.singularize.capitalize} was successfully deleted."
      else
        redirect_to @recipe, alert: "#{attachment_type.singularize.capitalize} not found."
      end
    else
      redirect_to @recipe, alert: 'Invalid attachment type or ID.'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, 
      :description, 
      :public,
      :main_photo,
      images: [], 
      videos: [],
      audios: [],
      documents: [],
      ingredients_attributes: [:id, :name, :amount, :note, :_destroy]
    )  
  end

end