class CatsController < ApplicationController


  def index
    @cats = Cat.all 
    render :index
  end

  def show

    debugger
    @cat = Cat.find(params[:id])



    render :show

  end


  def cat_params

    params.require(:cat_data).permit(:birth_date, :color, :name, :sex, :description)

  end

end
