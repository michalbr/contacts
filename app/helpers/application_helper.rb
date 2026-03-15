module ApplicationHelper
  def field_error(model, field)
    return unless model.errors[field].any?
    content_tag(:p, model.errors.full_messages_for(field).first, class: "mt-1 text-sm text-red-500")
  end
end
