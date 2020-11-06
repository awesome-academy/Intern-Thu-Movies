module ApplicationHelper
  def toastr_flash type
    case type
    when "danger"
      "toastr.error"
    when "success"
      "toastr.success"
    else
      "toastr.info"
    end
  end

  def display_error object, object_attr
    return unless object&.errors.present? && object.errors.key?(object_attr)

    errors = object.errors.messages[object_attr]
    content_tag :p, errors.join(", "), class: "display-error"
  end
end
