class Ability
  include CanCan::Ability

  def initialize user
    can :index, Movie
    return if user.blank?

    can %i(create destroy), [Comment, Rate, FavoriateMovie], user_id: user.id
    if user.normal?
      can :show, Movie
    elsif user.premium?
      can [:show, :watch], Movie
    elsif user.admin?
      can :manage, :all
    end
  end
end
