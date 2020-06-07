# bundle install

require 'selenium-webdriver'
require 'csv'

driver = Selenium::WebDriver.for :firefox
driver.navigate.to 'https://www.onlyoffice.com'

element = driver.find_element(id: 'navitem_about')
driver.action.move_to(element).perform

driver.find_element(id: 'navitem_about_about').click

bios = driver.find_element(class: 'owl-stage').find_elements(class: 'dev_info').map do |element|
  name = element.find_element(class: 'dev_info_name').attribute('innerHTML')
  role = element.find_element(class: 'dev_info_function').attribute('innerHTML')

  { n: name, r: role }
end

bios.uniq! # deletes duplicates

driver.quit

CSV.open('file.csv', 'wb') do |csv|
  csv << ['name', 'role']
  bios.each do |bio|
    name = bio[:n]
    role = bio[:r]
    csv << [name, role]
  end
end
