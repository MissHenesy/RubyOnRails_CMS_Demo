/*
  Universal Modal js
  Stolen from: https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
*/
$( document ).on('turbolinks:load', function() {
  console.log('** Loading Remote Modal JS **');
  $(function() {
    const modal_holder_selector = '#modal-holder';
    const modal_selector = '.modal';

    $(document).on('click', 'a[data-modal]', function() {
      const location = $(this).attr('href');
      // Load modal dialog from server
      $.get(
        location,
        data => { $(modal_holder_selector).html(data).find(modal_selector).modal() }
      );
      return false;
    });

    $(document).on('ajax:success', 'form[data-modal]', function(event){
      const [data, _status, xhr] = event.detail;
      const url = xhr.getResponseHeader('Location');
      if (url) {
        // Redirect to url
        window.location = url;
      } else {
        // Remove old modal backdrop
        $('.modal-backdrop').remove();
        // Update modal content
        const modal = $(data).find('body').html();
        $(modal_holder_selector).html(modal).find(modal_selector).modal();
      }

      return false;
    });
  });

});
