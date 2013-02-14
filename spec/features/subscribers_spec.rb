#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

feature 'Subscribers' do
  background do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'http://beverlymails.com/news/admin/index.php'
    Capybara.default_wait_time = 600
  end

  scenario 'Upload csv' do
    visit '/'

    fill_in 'ss_username', :with => 'admin'
    fill_in 'password', :with => '123456'
    click_on 'Login'

    visit '?Page=Subscribers&Action=Import'

    find("option[value='1']").click

    within '.PanelPlain' do
      click_on 'Next >>'
    end

    check 'overwrite'
    check 'headers'
    attach_file 'importfile', File.expand_path('public/lists/email_list.csv')

    within '.PanelPlain' do
      click_on "Next »"
    end

    within '.PanelPlain' do
      click_on "Next »"
    end

    click_on 'startImportSubscriber'
    
    
    page.should have_content 'The contact import has been completed successfully'
  end

end