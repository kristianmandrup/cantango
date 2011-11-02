module CanTango::Rails::Helpers::RestHelper
  CanTango.config.models.actions.each_pair do |model, actions|
    actions.actions_for :member do |member_action|
      class_eval %{
        def #{member_action}_#{model.to_s.underscore}_path obj, options = {}
          return unless can_perform_action?(user_type, :#{member_action}, obj)
          # use i18n translation on label
          link_to t(".#{member_action}"), rest_obj_action(obj, :#{member_action}, options)
        end
      }
    end

    actions.actions_for :collection do |collection_action|
      class_eval %{
        def #{collection_action}_#{model.to_s.underscore}_path obj, options = {}
          clazz = obj.kind_of?(Class) ? obj : obj.class
          return unless can_perform_action?(user_type, :#{collection_action}, clazz)
          # use i18n translation on label
          link_to t(".#{collection_action}"), send(action_method clazz, :#{collection_action}, options)
        end
      }
    end
  end

  CanTango.config.models.available_models.each do |model|
    class_eval %{
      def delete_#{model.to_s.underscore}_path obj, options = {}
        #{model}_path obj, {:method => 'delete'}.merge(options)
      end
    }
  end

  def link_to_new obj, user_type, options = {}
    clazz = obj.kind_of?(Class) ? obj : obj.class
    return unless can_perform_action?(user_type, :create, clazz)
    # use i18n translation on label
    link_to t(".create"), send(action_method clazz, :new, options)
  end

  def link_to_delete obj, user_type, options = {}
    return unless can_perform_action?(user_type, :delete, obj)
    # use i18n translation on label
    link_to t(".delete"), rest_obj_action(obj, :delete, options)
  end

  def link_to_edit obj, user_type, options = {}
    return unless can_perform_action?(user_type, :edit, obj)
    # use i18n translation on label
    link_to t(".edit"), rest_obj_action(obj, :edit, options)
  end

  def link_to_view obj, user_type, options = {}
    return unless can_perform_action?(user_type, :view, obj)
    # use i18n translation on label
    link_to t(".view"), send(view_method(obj), obj, options)
  end

  protected

  def can_perform_action? user_type, action, obj
    send(:"#{user_type}_can?", action, obj)
  end

  def view_method obj
    "#{obj.class.to_s.underscore}_path"
  end

  def rest_obj_action obj, action, options
    send action_method(obj, :edit), obj, options
  end

  def action_method obj, action
    "#{action}_#{obj.class.to_s.underscore}_path"
  end
end

