require 'test_helper'

class MapsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create map" do
    assert_difference('Map.count') do
      post :create, :map => { }
    end

    assert_redirected_to map_path(assigns(:map))
  end

  test "should show map" do
    get :show, :id => maps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => maps(:one).to_param
    assert_response :success
  end

  test "should update map" do
    put :update, :id => maps(:one).to_param, :map => { }
    assert_redirected_to map_path(assigns(:map))
  end

  test "should destroy map" do
    assert_difference('Map.count', -1) do
      delete :destroy, :id => maps(:one).to_param
    end

    assert_redirected_to maps_path
  end
end
