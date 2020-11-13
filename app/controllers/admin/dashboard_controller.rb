class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
  # http_basic_authenticate_with name: "Jungle", password:'book'
  def show
    @counts = {"product" => Product.count, "category" => Category.count }
  end
end
