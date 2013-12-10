#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TechnologyCategory.destroy_all
Technology.destroy_all
UploadFile.destroy_all
Category.destroy_all
Post.destroy_all
Job.destroy_all
ClientTestimonial.destroy_all
Project.destroy_all
Service.destroy_all
TeamPhoto.destroy_all
AdminUser.not_admin.destroy_all

tech = TechnologyCategory.create(:name => 'Technical Skills')
tech.technologies.create(:name => 'Ruby', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/ruby-language.png'))))
tech.technologies.create(:name => 'Rails', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/rails_mini.png'))))
tech.technologies.create(:name => 'Git', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/git.png'))))
tech.technologies.create(:name => 'Bash', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/bash.png'))))
tech.technologies.create(:name => 'RVM', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/rvm.png'))))

tech = TechnologyCategory.create(:name => 'SQL & Databases')
tech.technologies.create(:name => 'MySQL', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/mysql.png'))))
tech.technologies.create(:name => 'Postgre SQL', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/postgresql.png'))))
tech.technologies.create(:name => 'Sqlite', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/sqlite.png'))))
tech.technologies.create(:name => 'MongoDB', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/MongoDB.png'))))

tech = TechnologyCategory.create(:name => 'Javascript')
tech.technologies.create(:name => 'JQuery', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/jquery.png'))))
tech.technologies.create(:name => 'Mootools', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/mootools1.png'))))
tech.technologies.create(:name => 'Backbone.js', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/backbone.png'))))

tech = TechnologyCategory.create(:name => 'UI')
tech.technologies.create(:name => 'Bootstrap', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/bootstrap.png'))))
tech.technologies.create(:name => 'Web-App', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/Webapp_Icon.png'))))

tech = TechnologyCategory.create(:name =>'Styling')
tech.technologies.create(:name => 'HTML', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/html5.png'))))
tech.technologies.create(:name => 'HAML', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/haml.jpeg'))))
tech.technologies.create(:name => 'CSS', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/css3.png'))))
tech.technologies.create(:name => 'SASS', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/sass.png'))))

tech = TechnologyCategory.create(:name => 'Testing')
tech.technologies.create(:name => 'Cucumber', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/cucumber.jpeg'))))
tech.technologies.create(:name => 'Rspec', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/rspec.jpg'))))
tech.technologies.create(:name => 'Jasmin', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/Jasmin.jpg'))))
tech.technologies.create(:name => 'Capybara', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/capybara.jpg'))))
tech.technologies.create(:name => 'Minitest', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/minitest.jpg'))))

post = Post.create(:title => 'What’s new in Gemnasium?', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/gemnasium.png'))), :description => 'You now can choose exactly which projects you want to monitor and which one you don’t care about. Gemnasium will still try to automatically add/remove projects when syncing with Github, but as soon as you manually start or stop monitoring a project, it won’t override your choice anymore. So you now can freely choose which projects you want to track, and drop the others. To make it more clear, we’ve also cleaned up the profile view and you’ll now only see the monitored projects there. This will drastically reduce the signal to noise ratio so that you can focus on what matters to you.', :admin_user_id => 1)
post.categories.create(:name => 'post category 2')
post.tag_list = 'tag1, tag2, tag4'
post.save
post = Post.create(:title => 'Should you upgrade Rails from 3.2.12 to 3.2.13 ?', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/upgrade_rails.png'))), :description => 'We recommend you to not upgrade to Rails 3.2.13 and to wait for 3.2.14 to be released. But how to do so having in mind the 4 security breaches that still exists? Well, that’s simple, first of all, you might not be impacted by all of those issues and second, some monkey patches have been released to help you keep your application secure without upgrading. So keep calm, create a temporary hotfix branch until 3.2.14 is out and apply the patches you need.', :admin_user_id => 1)
post.categories.create(:name => 'post category 3')
post.tag_list = 'tag1, tag5, tag3'
post.save

Job.create(:title => 'developer', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/developer.jpg'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'team leader', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team_lead.jpg'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'lead developer', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/lead_developer.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'system administrator', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/sys_admin.jpg'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'advisor', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/advisor.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")

project1 = Project.create(:name => 'lol team', :team_size => 4, :upload_files => [UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/project.jpg'))), UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/project2.jpg')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
project2 = Project.create(:name => 'ror team', :team_size => 3, :upload_files => [UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/project3.gif')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")

Service.create(:name => 'Mobile version of web site development', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/mobile.jpg'))))
Service.create(:name => 'Web site development', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/site.jpg'))))
Service.create(:name => 'Web and mobile version  development', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/web_mobile.png'))))
Service.create(:name => 'Help with the existing project', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/help.jpg'))))

AdminUser.create(:email => 'leha@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'Leha', :last_name => 'Merk', :about => 'I am super puper', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'mixa@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'Mixa', :last_name => 'Belia', :about => 'I am super peper', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'kola@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'Kola', :last_name => 'Cookie', :about => 'I am super cookie', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'jaro@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'Jaro', :last_name => 'Boy', :about => 'I am super boy', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'san1@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'San1', :last_name => 'Late', :about => 'I am super late', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'san2@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'San2', :last_name => 'Claw', :about => 'I am super claw', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'veta@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'team', :first_name => 'Veta', :last_name => 'hzhz', :about => 'I am super hzhz', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team1.jpg'))))
AdminUser.create(:email => 'mana@example.com', :password => '12345678', :password_confirmation => '12345678', :role =>'manager', :first_name => 'Mana', :last_name => 'Pot', :about => 'I am super manager', :upload_file => UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team.jpg'))))

TeamPhoto.create(:title => 'Here we are!', :upload_files => [UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team_photo.jpg'))), UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team_photo2.jpg'))), UploadFile.new(:img_name => File.open(Rails.root.join('db/data_seed/team_photo3.jpg')))] )

ClientTestimonial.create(:comment_text => "Very nice work!", :project_id => project1.id, :author_name => "John Smith")
ClientTestimonial.create(:comment_text => "Awesome! You are my gods!", :project_id => project1.id, :author_name => "Darth Vader", :author_position => "Death Star capitan")
ClientTestimonial.create(:comment_text => "I am happy now!", :project_id => project2.id, :author_name => "Foo Bar", :author_position => "senior developer")