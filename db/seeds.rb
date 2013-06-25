# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TechnologyCategory.create(:name => 'Technical Skills')
TechnologyCategory.create(:name => 'SQL & Databases')
TechnologyCategory.create(:name => 'Javascript')
TechnologyCategory.create(:name => 'Styling')
TechnologyCategory.create(:name => 'UI')
TechnologyCategory.create(:name => 'Testing')

tech_category = TechnologyCategory.find_by_name('Technical Skills')
tech_category.technologies.create(:name => 'Ruby')
tech_category.technologies.create(:name => 'Rails')
tech_category.technologies.create(:name => 'Git')
tech_category.technologies.create(:name => 'Bash')
tech_category.technologies.create(:name => 'RVM')

tech_category = TechnologyCategory.find_by_name('SQL & Databases')
tech_category.technologies.create(:name => 'MySQL')
tech_category.technologies.create(:name => 'Postgre SQL')
tech_category.technologies.create(:name => 'Sqlite')
tech_category.technologies.create(:name => 'MongoDB')

tech_category = TechnologyCategory.find_by_name('Javascript')
tech_category.technologies.create(:name => 'JQuery')
tech_category.technologies.create(:name => 'Mootools')
tech_category.technologies.create(:name => 'Backbone.j')

tech_category = TechnologyCategory.find_by_name('UI')
tech_category.technologies.create(:name => 'Bootstrap')
tech_category.technologies.create(:name => 'Web-App')

tech_category = TechnologyCategory.find_by_name('Styling')
tech_category.technologies.create(:name => 'HTML')
tech_category.technologies.create(:name => 'HAML')
tech_category.technologies.create(:name => 'CSS')
tech_category.technologies.create(:name => 'SASS')

tech_category = TechnologyCategory.find_by_name('Testing')
tech_category.technologies.create(:name => 'Cucumber')
tech_category.technologies.create(:name => 'Rspec')
tech_category.technologies.create(:name => 'Jasmin')
tech_category.technologies.create(:name => 'Copybara')
tech_category.technologies.create(:name => 'Minitest')
