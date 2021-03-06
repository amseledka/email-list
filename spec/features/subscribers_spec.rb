#!/bin/env ruby
# encoding: utf-8

# I am so soryy for all these... they made me.

require 'spec_helper'

feature 'Subscribers' do
  background do
    Capybara.current_driver = :selenium
    Capybara.app_host = 'http://test.emailadminwebsite'
    Capybara.default_wait_time = 5000
  end

  scenario 'Upload csv' do
    visit '/'

    fill_in 'ss_username', :with => 'username'
    fill_in 'password', :with => 'password'
    click_on 'Login'

    visit '?Page=lists&Action=create'

    @list_name = Time.now.strftime("List from %b%d/%Y")
    fill_in 'Name', :with => @list_name
    fill_in 'OwnerName', :with => '{Interesting|Friendly|Personal|Exclusive|Special} {Notice|Alert|Reminder|Status|Notification|Update}'
    fill_in 'OwnerEmail', :with => ''
    uncheck 'NotifyOwner'

    within '.PanelPlain' do
      click_on 'Save'
    end

    a = page.all(:css, "li[id*='ele-']").map do |li|
      li['id'].split('-').last
    end
    @list_id = a.sort_by(&:to_i).last

    visit '?Page=Subscribers&Action=import'

    find("option[value='#{@list_id}']").click

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

    sleep 2000.seconds
  end

end