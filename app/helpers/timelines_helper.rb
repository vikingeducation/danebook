module TimelinesHelper

  def no_pictures_message(user)
    if user.photos.empty?
      "This user hasn't uploaded any photos yet"
    end
  end

  def no_friends_message(friends)
    if friends.empty?
      "This user hasn't added any friends yet :("
    end
  end

  def image_or_linked_image(photo, user)
    if user.friended_by?(current_user) || user == current_user
      link_to photo_path(photo) do
        image_tag photo.data.url(:thumb), class: "img img-responsive"
      end
    else
      image_tag photo.data.url(:thumb), class: "img img-responsive"
    end
  end

  def profile_pic_or_generic(authorable)
    image_tag authorable.author.profile_pic ? authorable.author.profile_pic.data.url(:thumb) : random_user_image, class: "img img-responsive"
  end


end
