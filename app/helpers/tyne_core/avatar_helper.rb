module TyneCore
  module AvatarHelper
    def avatar_url(user, options={})

      default_url = "#{options[:url]}assets/guest.png"

      return default_url unless user.gravatar_id

      "http://gravatar.com/avatar/#{user.gravatar_id}.png?s=#{options[:width]}&d=#{CGI.escape(default_url)}"
    end

    def avatar(user, options={})
      options.reverse_merge!(:url => "/", :width => 24)
      image_tag avatar_url(user, options), :class => 'avatar', :width => 24
    end
  end
end
