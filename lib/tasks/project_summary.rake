namespace :project_summary do

  desc "send weekly summary of projects on monday"
  task send: :environment do
    date = DateTime.now

    if date.wday == 2
      @users = User.where(role: [2,3])
      @users.each do |user|
        next if missing_or_no_tasks?(user, date)
        ProjectSummaryMailer.weekly(user, date.last_week).deliver_now
      end
    end
  end

  private

  def missing_or_no_tasks?(user, date)
    user.last_week_tasks(date.last_week).empty? || user.is_missing || (user.partner && user.partner.is_missing)
  end
end
