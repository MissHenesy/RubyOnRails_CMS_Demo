# app/helpers/carousel_helper.rb
# Code borrowed from:
# https://www.toptal.com/ruby-on-rails/rails-helper-bootstrap-carousel
module CarouselHelper
  def carousel_for(image_hash)
    Carousel.new(self, image_hash).html
  end

  class Carousel
    def initialize(view, image_hash)
      @view = view
      @image_hash = image_hash
      @images = []
      @image_hash.each do |i|
        @images << i[:image_url]
      end
      @uid = SecureRandom.hex(6)
    end

    def html
      content = safe_join([indicators, slides, controls])
      content_tag(:div, content, id: "carousel_#{uid}", class: 'carousel slide', 'data-bs-ride': 'carousel')
    end

    private

    attr_accessor :view, :images, :uid
    delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

    def indicators
      items = images.count.times.map { |index| indicator_tag(index) }
      content_tag(:ol, safe_join(items), class: 'carousel-indicators')
    end

    def indicator_tag(index)
      options = {
        class: (index.zero? ? 'active' : ''),
        'data-bs-target': "#carousel_#{uid}",
        'data-bs-slide-to': index
      }

      content_tag(:li, '', options)
    end

    def slides
      #items = images.map.with_index { |image, index| slide_tag(image, index.zero?) }
      items = slide_tag(@image_hash)
      content_tag(:div, safe_join(items), class: 'carousel-inner')
    end

    def slide_tag(img_hash)
      final_tag = []
      img_hash.each_with_index do |val, idx|
        is_active = idx.zero?
        options = {
          class: (is_active ? 'carousel-item active' : 'carousel-item'),
        }
        img_tag = image_tag("#{val[:image_url]}", class: 'd-block w-100')
        caption_div = content_tag(:div, '', class: 'd-none d-md-block img-caption')
        caption_header = content_tag(:h5, "#{val[:title]}")
        caption_paragraph = content_tag(:p, "#{val[:caption]}")

        slide_content = img_tag + caption_div + caption_header + caption_paragraph

        final_tag << content_tag(:div, slide_content, options)
      end
      final_tag
    end

    def controls
      safe_join([control_tag('left'), control_tag('right')])
    end

    def control_tag(direction)
      pn_direction = direction == 'left' ? 'prev' : 'next'
      pn_direction_text = direction == 'left' ? 'Previous' : 'Next'
      options = {
        class: "carousel-control-#{pn_direction}",
        "data-bs-slide": "#{pn_direction}",
        role: "button"
      }

      #icon = content_tag(:i, '', class: "glyphicon glyphicon-chevron-#{direction}")
      span1 = content_tag(:span, '', class: "carousel-control-#{pn_direction}-icon", "aria-hidden": "true")
      span2 = content_tag(:span, "#{pn_direction_text}", class: 'sr-only')
      span1 << span2
      control = link_to(span1, "#carousel_#{uid}", options)

    end
  end
end
