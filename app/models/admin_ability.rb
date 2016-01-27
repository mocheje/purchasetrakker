# app/models/admin_ability.rb

# All back end users (i.e. Active Admin users) are authorized using this class
class AdminAbility
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    # restrict abilities to every user
    cannot :manage, :all
    cannot :read, :all
    cannot :edit, :all

    if user.role? :admin
      can :read, :all
    end
  end
end