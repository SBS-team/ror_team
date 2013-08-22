class Ability

  include CanCan::Ability

  def initialize(current_user)
    case current_user.role
      when 'admin'
        can :manage, :all
        cannot :create, [Resume,ActsAsTaggableOn::Tag]
        cannot :update, [Resume, LiveChat, ActsAsTaggableOn::Tag]
      when 'manager'
        can :read, :all
        cannot :read, [UploadFile, AdminUser]
        can :manage, [Project, Resume, Job, Post, TeamPhoto, Comment, Category]
      when 'team_lead'
        can :read, :all
        cannot :read, [UploadFile, AdminUser]
        can :manage, [Category, Service, Technology, TechnologyCategory]
      when 'team'
        can :read, [TeamPhoto, Project, Service, Category, Technology, TechnologyCategory]
    end
  end

end
