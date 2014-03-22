require 'spec_helper'

feature 'Requesting offers', js: true do
  context 'with valid params' do
    scenario 'when user has no offers in the system' do
      visit root_path
      fill_in :uid, with: 'test'
      fill_in :page, with: 1
      click_button 'Load offers'
      expect(page).to have_content 'No offers'
    end

    scenario 'when user has offers in the system' do
      pending('Couldn\'t actually test - would need offers in sponsorpay api')
    end
  end

  context 'with invalid params' do
    scenario 'without a user id' do
      visit root_path
      fill_in :page, with: 1
      click_button 'Load offers'
      expect(page).to have_content 'can\'t be blank'
    end

    scenario 'without a page' do
      visit root_path
      fill_in :uid, with: 'test'
      click_button 'Load offers'
      expect(page).to have_content 'can\'t be blank'
    end

    scenario 'with non-numerical page' do
      visit root_path
      fill_in :page, with: 'aaa'
      click_button 'Load offers'
      expect(page).to have_content 'must be a positive integer'
    end

    scenario 'with page as a negative integer' do
      visit root_path
      fill_in :page, with: -1
      click_button 'Load offers'
      expect(page).to have_content 'must be a positive integer'
    end
  end
end
