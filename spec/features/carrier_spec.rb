# frozen_string_literal: true

RSpec.describe Carrier do
  let(:carrier) { carriers(:carrier) }
  let(:user) { users(:user) }

  describe 'USER role' do
    before do
      visit root_url
      sign_in user
    end

    scenario 'SHOW' do
      visit carriers_url
      click_link carrier.name

      expect(page).to have_content('test carrier')
      expect(page).to have_content('babywearing')
      expect(page).to have_content('test model')
    end
  end

  describe 'ADMIN role' do
    let(:category) { categories(:category) }
    let(:washington) { locations(:washington) }
    let(:lancaster) { locations(:lancaster) }
    let(:carrier) { carriers(:carrier) }
    let(:user) { users(:admin) }
    let(:loan) { loans(:outstanding) }

    before do
      visit root_url
      sign_in user
    end

    scenario 'SHOW' do
      visit carriers_url
      click_link carrier.name

      expect(page).to have_content('test carrier')
      expect(page).to have_content('babywearing')
      expect(page).to have_content('test model')
      expect(page).to have_content(loan.checkout_volunteer.name)
    end

    scenario 'NEW' do
      visit new_carrier_url
      expect(page).to have_content('New Carrier')
      expect(page).to have_content('Name')
      expect(page).to have_content('Item')
      expect(page).to have_content('Manufacturer')
      expect(page).to have_content('Model')
      expect(page).to have_content('Color')
      expect(page).to have_content('Safety Link')

      expect(page).to have_current_path '/carriers/new'
    end

    scenario 'EDIT with all required fields' do
      visit edit_carrier_url(carrier.id)

      fill_in 'Name', with: 'Updated Name'
      fill_in 'Model', with: 'Updated Model'
      find('#carrier_current_location_id').find(:option, lancaster.name).select_option
      select 'Sold', from: 'State'
      click_on 'Update Carrier'

      expect(page).to have_content('Updated Name')
      expect(page).to have_content('Updated Model')
      expect(page).to have_content('Lancaster')
      expect(page).to have_content('Sold')
    end

    scenario 'EDIT without any required fields' do
      visit edit_carrier_url(carrier.id)

      fill_in 'Name', with: nil
      fill_in 'Item', with: nil
      click_on 'Update Carrier'

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Item can\'t be blank')
    end

    scenario 'DESTROY' do
      visit carrier_url(carrier.id)

      click_on 'Delete'
      expect(page).to have_content('Carrier successfully destroyed')
    end

    scenario 'CREATE with all required fields' do
      visit new_carrier_url
      fill_in 'Name', with: 'Test Name'
      fill_in 'Item', with: 9
      fill_in 'Manufacturer', with: 'Test Manufacturer'
      fill_in 'Model', with: 'Test Model'
      fill_in 'Color', with: 'White'
      find('#carrier_category_id').find(:option, category.name).select_option

      click_on 'Create Carrier'

      expect(page).to have_content('Carrier successfully created')
    end

    scenario 'CREATE with duplicated item_id' do
      visit new_carrier_url
      fill_in 'Item', with: carrier.item_id

      click_on 'Create Carrier'

      expect(page).to have_content('Item ID has already been taken')
    end

    scenario 'CREATE without required fields' do
      visit new_carrier_url(carrier.id)

      click_on 'Create Carrier'

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Item can\'t be blank')
    end

    scenario 'ADD new carrier' do
      visit root_url
      click_on 'ADD CARRIER'

      expect(page).to have_content('New Carrier')
      expect(page).to have_content('Name')
      expect(page).to have_content('Item')
      expect(page).to have_content('Manufacturer')
      expect(page).to have_content('Model')
      expect(page).to have_content('Color')
      expect(page).to have_content('State')

      expect(page).to have_current_path '/carriers/new'
    end
  end

  describe 'VOLUNTEER role' do
    let(:category) { categories(:category) }
    let(:washington) { locations(:washington) }
    let(:lancaster) { locations(:lancaster) }
    let(:carrier) { carriers(:carrier) }
    let(:user) { users(:volunteer) }

    before do
      visit root_url
      sign_in user
    end

    scenario 'SHOW' do
      visit carriers_url
      click_link carrier.name

      expect(page).to have_content('test carrier')
      expect(page).to have_content('babywearing')
      expect(page).to have_content('test model')
      expect(page).to have_content('Available')
    end

    scenario 'EDIT with all required fields' do
      visit edit_carrier_url(carrier.id)

      fill_in 'Name', with: 'Updated Name'
      fill_in 'Model', with: 'Updated Model'
      find('#carrier_current_location_id').find(:option, lancaster.name).select_option
      click_on 'Update Carrier'

      expect(page).to have_content('Updated Name')
      expect(page).to have_content('Updated Model')
      expect(page).to have_content('Lancaster')
    end

    scenario 'EDIT without any required fields' do
      visit edit_carrier_url(carrier.id)

      fill_in 'Name', with: nil
      fill_in 'Item', with: nil
      click_on 'Update Carrier'

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Item can\'t be blank')
    end

    scenario 'DESTROY' do
      visit carrier_url(carrier.id)

      click_on 'Delete'
      expect(page).to have_content('Carrier successfully destroyed')
    end
  end

  describe 'USER role' do
    let(:carrier) { carriers(:carrier) }
    let(:user) { users(:member) }

    before do
      visit root_url
      sign_in user
    end

    scenario 'SHOW' do
      visit carriers_url
      click_link carrier.name

      expect(page).to have_content('test carrier')
      expect(page).to have_content('babywearing')
      expect(page).to have_content('test model')
    end
  end

  describe 'view mode' do
    before do
      sign_in user
      visit carriers_url
    end

    it 'can set the view mode to list' do
      click_on(class: 'carrier-list-link')

      expect(page).to have_current_path(carriers_url(view: 'list'))
      expect(page).to have_css('table')
    end

    it 'can set the view mode to icon' do
      click_on(class: 'carrier-icon-link')

      expect(page).to have_current_path(carriers_url(view: 'icon'))
      expect(page).not_to have_css('table')
    end

    it 'uses view mode from cookie' do
      Capybara.current_session.driver.browser.set_cookie('carrier_view=list')
      visit carriers_url
      expect(page).to have_css('table')
    end
  end
end
