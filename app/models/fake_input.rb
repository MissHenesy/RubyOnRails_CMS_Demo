class FakeInput < SimpleForm::Inputs::Base
  # This method usually returns input's html like <input ... />
  # but in this case it returns just a value of the attribute.
  # Stolen from:
  # https://stackoverflow.com/questions/9237612/when-using-simple-form-in-rails-how-can-i-use-it-just-to-show-data-for-some-of
  def input
    @builder.object.send(attribute_name)
  end
end
