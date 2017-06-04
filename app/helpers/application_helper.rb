module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end

def picture_img(topic)
  return image_tag(topic.picture) if topic.picture?
end

def profile_img(user)
  return image_tag(user.avatar, alt: user.name)if user.avatar?

  unless user.provider.blank?
    img_url = user.image_url
  else
    img_url = 'no_avatar.png'
  end
  image_tag(img_url, alt: user.name)
end

def new_message_arrival_count(user)
  count = 0
  conversations = Conversation.all
  conversations.each do |conversation|
    if conversation.target_user(user).present?
      if conversation.messages.last != nil
        if current_user.id != conversation.messages.last.user_id && conversation.messages.last.read == false
          count += 1
        end
      end
    end
  end
  @count = count
  return count
end

module ActionView
  module Helpers
    module FormHelper
      def error_messages!(object_name, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if !resource || resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

        html = <<-HTML
          <div class="alert alert-danger">
            <ul>#{messages}</ul>
          </div>
        HTML

        html.html_safe
      end

      def error_css(object_name, method, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if resource.errors.empty?

        resource.errors.include?(method) ? 'has-error' : ''
      end
    end

    class FormBuilder
      def error_messages!(options = {})
        @template.error_messages!(@object_name, options.merge(object: @object))
      end

      def error_css(method, options = {})
        @template.error_css(@object_name, method, options.merge(object: @object))
      end
    end
  end
end
