# Appends a span to an input in order to make it editable
class EditableInput < SimpleForm::Inputs::StringInput
  # Overwrites the existing input method to render the input with a spen with the edit function
  # def input
  #   original_input = @builder.text_field(attribute_name, input_html_options)
  #   edit_span = template.content_tag :button, "Foo", :class => "btn", :type => :button

  #   template.content_tag :div, "#{original_input}#{edit_span}".html_safe, :class => "input-append"
  # end
end
