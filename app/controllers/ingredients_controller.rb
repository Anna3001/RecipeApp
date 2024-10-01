class IngredientsController < ApplicationController
  before_action :set_recipe
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = @recipe.ingredients
  end

  def show
  end

  def new
    @ingredient = @recipe.ingredients.build
  end

  def create
    @ingredient = @recipe.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient was successfully created.'
    else
      render 'recipes/show' # Render the recipe show page again if validation fails
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to recipe_ingredients_path(@recipe), notice: 'Ingredient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to recipe_ingredients_path(@recipe), notice: 'Ingredient was successfully destroyed.'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient
    @ingredient = @recipe.ingredients.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity)
  end
end