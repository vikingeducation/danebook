class ProfilesController < ApplicationController

  def update
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @profile.update(profile_params)
    flash[:success] = "Profile updated."
    redirect_to @user
  end

  private

    def profile_params
      params.require(:profile).permit(
        :id,
        :words,
        :about,
        { birthday_attributes: [
          :id,
          'date_object(2i)',
          'date_object(3i)',
          'date_object(1i)'
        ] },
        :college,
        { hometown_attributes: [
          :id,
          { address_attributes: [
            :id,
            :city_id,
            :state_id,
            :country_id
          ] }
        ] },
        { residence_attributes: [
          :id,
          { address_attributes: [
            :id,
            :city_id,
            :state_id,
            :country_id
          ] }
        ] },
        { contact_info_attributes: [:email, :phone] })
    end
end
