# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user.user_type
    when 'Donor'
      can :read, Benefit
      can :create, Donation
      can :read, Project
      can :manage, User, id: user.id
    when 'Company'
      can :manage, Benefit
      can :manage, Contract
      can :create, Donation
      can :read, Project
      can %i[read destroy], Requirement
      can :manage, User, id: user.id
    when 'SocialCompany'
      can :read, Benefit
      can :manage, Project
      can :manage, Contract
      can :manage, Requirement
      can :manage, User, id: user.id
    else
      can :read, User
      can :read, Project
    end
  end
end
