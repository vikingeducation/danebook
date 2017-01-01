# Users Helper
module UsersHelper
  def profile_edit_button(user)
    if current_user == user
      button_to 'Edit Profile', edit_profile_path, method: :get, class: "btn btn-info btn-sm"
    end
  end

  def profile_pic(user)
    photo = Photo.where(id: user.profile.picture_id)
    if photo.empty?
      image_tag('user_silhouette_generic.gif', size: '150x150', class: 'fit-div')
    else
      image_tag(photo[0].image.url(:thumb), class: 'fit-div')
    end
  end

  def cover_pic_url(user)
    photo = Photo.where(id: user.profile.cover_id)
    if photo.empty?
      '/images/manhattan.jpg'
    else
      photo[0].image.url
    end
  end
end
