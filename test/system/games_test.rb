require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector '.letters div', count: 10
  end

  test 'Get a message that the word is not in the grid' do
    visit new_url
    fill_in 'word', with: 'car'
    click_on 'Play'

    assert_text "Sorry"
  end

  test 'Get a message it/s not a valid English word' do
    visit new_url
    fill_in 'word', with: 'car'
  end

  test 'Get a Congratulations message' do
  end
end
