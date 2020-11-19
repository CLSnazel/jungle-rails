require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "they can click on add to add item to cart" do 
    visit root_path

    # cart = first('a[href="cart"')
    expect(page).to have_text 'My Cart (0)'

    first('article footer form button').click

    expect(page).to have_text 'My Cart (1)'
  end
end
