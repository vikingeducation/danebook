class UserMailer < ApplicationMailer
  default from: 'danebook@example.com'

  def activation(user)
    @user = user
    mail to: user.email, subject: 'Account Activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password Reset'
  end

  def notify_like(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
  end

  def notify_comment(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
  end

  def recommend_friends(user,other_users)
    @other_users = other_users
    @user = user

    # building other users' thumbnail photos
    @other_users.each do |user|
      if user.avatar.path
        attachments.inline["#{user.id}." + "#{user.avatar_content_type}"] = File.read(user.avatar.path(:thumb))
      else
        image = user.avatar.options[:default_url]
        attachments.inline["#{user.id}.gif.png"] = File.read(Rails.root.join "app", "assets", "images", "#{image}")
      end
    end

    mail to: user.email, subject: 'Add some friends!'
  end

end
