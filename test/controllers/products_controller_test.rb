require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { child_id: @product.child_id, image1_link: @product.image1_link, image2_link: @product.image2_link, image3_link: @product.image3_link, introduction: @product.introduction, introduction_voice_link: @product.introduction_voice_link, state: @product.state, title: @product.title }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { child_id: @product.child_id, image1_link: @product.image1_link, image2_link: @product.image2_link, image3_link: @product.image3_link, introduction: @product.introduction, introduction_voice_link: @product.introduction_voice_link, state: @product.state, title: @product.title }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
