# 2021-12-29 SLH:: Modal Service added, per:
# https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
# https://github.com/jetthoughts/remote_modals_demo/blob/master/app/controllers/messages_controller.rb
class ModalResponder < ActionController::Responder
  cattr_accessor :modal_layout
  self.modal_layout = 'modal'

  def render(*args)
    options = args.extract_options!
    if request.xhr?
      options.merge! layout: modal_layout
    end
    controller.render *args, options
  end

  def default_render(*args)
    render(*args)
  end

  def redirect_to(options)
    if request.xhr?
      head :ok, location: controller.url_for(options)
    else
      controller.redirect_to(options)
    end
  end
end
