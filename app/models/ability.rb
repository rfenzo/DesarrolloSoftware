# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    visitors_ability

    return unless user.present?

    can %i[dashboard personal_info], User, id: user.id

    case user.user_type
    when 'Donor'
      can :create, Donation
      can %i[donations earned_benefits], User, id: user.id
    when 'Company'
      can :create, Donation
      can :manage, Benefit, user_id: user.id
      can :manage, Contract, benefit: { user_id: user.id }
      can %i[donations offered_benefits contracts requirements new_contract], User, id: user.id
      can %i[read destroy], Requirement, user: { id: user.id }
    when 'SocialCompany'
      can :destroy, Contract, project: { user_id: user.id }
      can :manage, Project, user_id: user.id
      can :manage, Requirement, project: { user_id: user.id }
      can %i[social_projects requirements find_sponsor], User, id: user.id
    end
  end

  def visitors_ability
    can :read, [Project, Benefit]
    can %i[companies company social_companies social_company], User
  end
end
