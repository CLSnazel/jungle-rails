require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "they can click on a product to see details using the details button" do
    #navigate to root
    visit root_path

    first('article header a').click
    expect(page).to have_css 'section.products-show'

  end

  scenario "they can click on a product to see details using the  product header" do
    #navigate to root
    visit root_path

    first('article footer a').click
    expect(page).to have_css 'section.products-show'

  end
end
