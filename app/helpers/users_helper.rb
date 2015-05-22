module UsersHelper
  def sort_users_by_wins(users)
    users.sort_by do |user|
      [user.win_percentage, user.spy_win_percentage, user.resistance_win_percentage]
    end.reverse
  end
end
