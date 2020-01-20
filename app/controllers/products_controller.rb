class ProductsController < ApplicationController

  layout false, except: [:detail, :show] 
  before_action :set_categories, only: %w[create]
  
  def new
    @parents = Category.all.order("id ASC").limit(13)
    @product = Product.new
    @prefecture = Prefecture.all
    @brand = Brand.all
    5.times { @product.images.new } 
  end

  def category_children
    @category_children = Category.find(params[:productcategory]).children 
  end
  # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
 
  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    # binding.pry
    if @product.save
      redirect_to root_path
    else
      @brand = Brand.all
      5.times { @product.images.new }
      render 'new'
    end
  end

  def index
    @products = Product.includes(:images)
    @product = Product.find[:id]
    @image = Image.all
  end
  
  def show
    @product = Product.find(params[:id])
    @category = Category.all
  end

  def edit
    @product = Product.find(params[:id])
    @images = Image.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.user_id == current_user.id
    @product.update(product_params)
    end
    redirect_to product_path(@product)
  end

  def detail
    @product = Product.find(params[:id])
  end

  def dynamic_select_category
    @category = Category.find(params[:category_id])
  end

  def destroy
    product = Product.find(params[:id])
    if product.user.id == current_user.id
      product.delete
    end
    redirect_to root_path
  end

  # def search
  #   respond_to do |format|
  #     format.html
  #     format.json do
  #      @children = Category.find(params[:parent_id]).children
  #      #親ボックスのidから子ボックスのidの配列を作成してインスタンス変数で定義
  #     end
  #   end
  # end

  private
  def product_params
    params.require(:product).permit( :title, :info, :status, :postage, :prefecture_id, :shipping, :day, :price, :category_id, :brand_id, images_attributes: [:image, :_destroy, :id])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end

private
def set_categories
  @parent_categories = Category.roots
  @default_child_categories = @parent_categories.first.children
  @default_child_child_childcategories = @default_child_categories.first.children
end

