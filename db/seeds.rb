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

Category.destroy_all
UploadFile.destroy_all
Post.destroy_all
post = Post.create(:title => 'Tech-Angels SAS is a French company based in Paris',  :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'For each of your project’s dependencies you can now quickly check what has changed. Just click on the Changelog viewer icon and start reading! Gemnasium will automatically aggregate changelog data and scope it to what matters to you: the changes between your current version and the latest stable!', :admin_id => 1)
post.categories.create(:name => 'post category 1')
post.tag_list = 'tag1, tag2, tag3'
post.save
post = Post.create(:title => 'What’s new in Gemnasium?', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'You now can choose exactly which projects you want to monitor and which one you don’t care about. Gemnasium will still try to automatically add/remove projects when syncing with Github, but as soon as you manually start or stop monitoring a project, it won’t override your choice anymore. So you now can freely choose which projects you want to track, and drop the others. To make it more clear, we’ve also cleaned up the profile view and you’ll now only see the monitored projects there. This will drastically reduce the signal to noise ratio so that you can focus on what matters to you.', :admin_id => 1)
post.categories.create(:name => 'post category 2')
post.tag_list = 'tag1, tag2, tag4'
post.save
post = Post.create(:title => 'Should you upgrade Rails from 3.2.12 to 3.2.13 ?', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'We recommend you to not upgrade to Rails 3.2.13 and to wait for 3.2.14 to be released. But how to do so having in mind the 4 security breaches that still exists? Well, that’s simple, first of all, you might not be impacted by all of those issues and second, some monkey patches have been released to help you keep your application secure without upgrading. So keep calm, create a temporary hotfix branch until 3.2.14 is out and apply the patches you need.', :admin_id => 1)
post.categories.create(:name => 'post category 3')
post.tag_list = 'tag1, tag5, tag3'
post.save
post = Post.create(:title => 'Tech-Angels SAS is a French company based in Paris', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'For each of your project’s dependencies you can now quickly check what has changed. Just click on the Changelog viewer icon and start reading! Gemnasium will automatically aggregate changelog data and scope it to what matters to you: the changes between your current version and the latest stable!', :admin_id => 1)
post.categories.create(:name => 'post category 4')
post.tag_list = 'tag5, tag2, tag3'
post.save
post = Post.create(:title => 'What’s new in Gemnasium?', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'You now can choose exactly which projects you want to monitor and which one you don’t care about. Gemnasium will still try to automatically add/remove projects when syncing with Github, but as soon as you manually start or stop monitoring a project, it won’t override your choice anymore. So you now can freely choose which projects you want to track, and drop the others. To make it more clear, we’ve also cleaned up the profile view and you’ll now only see the monitored projects there. This will drastically reduce the signal to noise ratio so that you can focus on what matters to you.', :admin_id => 1)
post.categories.create(:name => 'post category 5')
post.tag_list = 'tag1, tag2, tag5'
post.save
post = Post.create(:title => 'Should you upgrade Rails from 3.2.12 to 3.2.13 ?', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => 'We recommend you to not upgrade to Rails 3.2.13 and to wait for 3.2.14 to be released. But how to do so having in mind the 4 security breaches that still exists? Well, that’s simple, first of all, you might not be impacted by all of those issues and second, some monkey patches have been released to help you keep your application secure without upgrading. So keep calm, create a temporary hotfix branch until 3.2.14 is out and apply the patches you need.', :admin_id => 1)
post.categories.create(:name => 'post category 6')
post.tag_list = 'tag1, tag2, tag4'
post.save

Job.destroy_all
Job.create(:title => 'developer', :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'team leader', :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'lead developer', :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'system administrator', :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'advisor', :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")

Project.destroy_all
Project.create(:name => 'lol team', :team_size => 4, :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('public/Screen.png')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Project.create(:name => 'ror team', :team_size => 3, :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('public/Screen.png')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")

Service.destroy_all
Service.create(:name => 'Mobile version of web site development', :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png')))])
Service.create(:name => 'Web site development. It includes', :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png')))])
Service.create(:name => 'Web and mobile version  development.', :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png')))])
Service.create(:name => 'Help with the existing project', :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png')))])