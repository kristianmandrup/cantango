class RestHelper
  CanTango.config.models.available_models.each do |model|
    class_eval %{
      def delete_#{model}_path obj, options = {}
        #{model}_path obj, {:method => 'delete'}.merge(options)
      end
    }
  end

  def link_to_new obj, user_type, options = {}
    return unless send(:"#{user_type}_can?", :create, obj)
    # use i18n translation on label
    link_to t(".create"), action_method(obj, :new)
  end

  def link_to_delete obj, user_type, options = {}
    return unless send(:"#{user_type}_can?", :delete, obj)
    # use i18n translation on label
    link_to t(".delete"), send action_method(obj, :delete), obj, options
  end

  def link_to_edit obj, user_type, options = {}
    return unless send(:"#{user_type}_can?", :edit, obj)
    # use i18n translation on label
    link_to t(".edit"), send action_method(obj, :edit), obj, options
  end

  def link_to_view obj, user_type, options = {}
    return unless send(:"#{user_type}_can?", :edit, obj)
    # use i18n translation on label
    link_to t(".view"), send view_method(obj), obj, options)
  end

  protected

  def view_method obj
    "#{obj.class.to_s.underscore}_path"
  end

  def action_method obj, action
    "#{action}_#{obj.class.to_s.underscore}_path"
  end
end

