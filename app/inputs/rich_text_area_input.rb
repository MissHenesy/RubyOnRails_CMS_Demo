# 2022-01-16 SLH - Using ActionText with Simple Form requires this class.
# See: https://gist.github.com/murny/58da5c7892cbd37d698b2130d3cacf2c
# put this in app/inputs/rich_text_area_input.rb
class RichTextAreaInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.rich_text_area(attribute_name, merged_input_options)
  end
end
