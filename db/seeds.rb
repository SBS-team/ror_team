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
Project.destroy_all
Service.destroy_all

tech = TechnologyCategory.create(:name => 'Technical Skills')
tech.technologies << Technology.create(:name => 'Ruby', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Rails', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Git', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Bash', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'RVM', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))

tech = TechnologyCategory.create(:name => 'SQL & Databases')
tech.technologies << Technology.create(:name => 'MySQL', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Postgre SQL', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Sqlite', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'MongoDB', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))

tech = TechnologyCategory.create(:name => 'Javascript')
tech.technologies << Technology.create(:name => 'JQuery', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Mootools', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Backbone.j', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))

tech = TechnologyCategory.create(:name => 'UI')
tech.technologies << Technology.create(:name => 'Bootstrap', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Web-App', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))

tech = TechnologyCategory.create(:name =>'Styling')
tech.technologies << Technology.create(:name => 'HTML', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'HAML', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'CSS', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'SASS', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
#
tech = TechnologyCategory.create(:name => 'Testing')
tech.technologies << Technology.create(:name => 'Cucumber', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Rspec', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Jasmin', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Copybara', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
tech.technologies << Technology.create(:name => 'Minitest', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))

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

Job.create(:title => 'developer', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'team leader', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'lead developer', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'system administrator', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Job.create(:title => 'advisor', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))), :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")

Project.create(:name => 'lol team', :team_size => 4, :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('public/Screen.png')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")
Project.create(:name => 'ror team', :team_size => 3, :upload_files => [UploadFile.create(:img_name => File.open(Rails.root.join('public/Screen.png')))], :since => 1.month.ago, :till => Time.now, :description => "The engineering tracks of these programs teach students how to construct, analyze and maintain software through lectures and laboratory sessions. Programs include topics in computer programming, operating systems and networks. In many programs, the capstone requirement is a senior design project that allows students to apply the principles they've learned to an original concept. Students may also take part in cooperative internships to gain experience as part of an engineering program.")


Service.create(:name => 'Mobile version of web site development', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
Service.create(:name => 'Web site development. It includes', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
Service.create(:name => 'Web and mobile version  development.', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))
Service.create(:name => 'Help with the existing project', :upload_file => UploadFile.create(:img_name => File.open(Rails.root.join('test/factories/files/image.png'))))