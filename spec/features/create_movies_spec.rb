require 'rails_helper'

feature 'user creates movies', %Q{
  As a user
  I want to upload movies file
  So i can save and view them
  } do
    scenario 'valid data' do

      visit movies_path

      attach_file "File", File.join(Rails.root, "spec/support/files/example.csv")

      click_button 'Upload'

      expect(page).to have_content("Movies successfully uploaded")
      expect(Movie.count).to eq(10)
    end

    scenario 'with no file' do
      visit movies_path

      click_button 'Upload'

      expect(page).to have_content('Please attach file')
      expect(Movie.count).to eq(0)
    end
  end
