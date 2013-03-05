#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

feature 'Subscribers' do
  background do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'http://maileroo.com/iem/admin/index.php'
    Capybara.default_wait_time = 3000
  end

  scenario 'Upload csv' do
    visit '/'

    fill_in 'ss_username', :with => 'reg'
    fill_in 'password', :with => 'ckone001'
    click_on 'Login'

    visit '?Page=Subscribers&Action=import'

    find("option[value='6']").click

    within '.PanelPlain' do
      click_on 'Next >>'
    end

    check 'overwrite'
    check 'headers'
    attach_file 'importfile', File.expand_path('db/lists/email_list.csv')

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