# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user, controller_namespace
    undified_user
    return if user.blank?
    case controller_namespace
    when "Admin"
      permission_admin if user.admin?
    else
      permission_user user if user
    end
  end

  private

  def permission_admin
    can :manage, [:cart, :static_page, Category, Product]
    can %i(read create approve reject), Order
    can %i(read update), User
  end

  def permission_user user
    can :manage, %i(cart static_page)
    can %i(read create cancel), Order, user_id: user.id
    can %i(read update), User, id: user.id
    can :read, Category
    can %i(read filter), Product
  end

  def undified_user
    can :manage, %i(cart static_page)
    can :read, Category
    can %i(read filter), Product
    can :create, User
  end
end
