module ModalHelper
  def modal(type, options={}, &block)
    case type
    when :basic
      basic_modal(options, &block)
    when :with_button
      modal_with_button(options, &block)
    when :custom_modal_with_header
      custom_modal_with_header(options, &block)
    else
      raise "Modal type #{type} is not a known modal!"
    end
  end

  def basic_modal(options, &block)
    header = modal_header(options)

    render partial: 'modals/basic_modal',
      locals: {
        header: options.fetch(:header) { true },
        header_close_button: options.fetch(:header_close_button) { true },
        modal_id: options.fetch(:modal_id) { "generic-modal" },
        modal_class: options.fetch(:modal_class) { "" },
        modal_header: header,
        modal_body: capture(&block),
        footer: options.fetch(:footer) { true },
        open_on_page_load: options.fetch(:open_on_page_load) { false },
        set_cookie: options.fetch(:set_cookie) { false },
      }
  end

  def modal_with_button(options, &block)
    header = modal_header(options)

    render partial: 'modals/modal_with_button',
      locals: {
        header: options.fetch(:header) { true },
        header_close_button: options.fetch(:header_close_button) { true },
        modal_id: options.fetch(:modal_id) { "generic-modal" },
        modal_class: options.fetch(:modal_class) { "" },
        modal_header: header,
        modal_body: capture(&block),
        footer_button_class: options.fetch(:footer_button_class) { "btn-primary" },
        footer_button_icon: options.fetch(:footer_button_icon) { nil },
        footer_button_text: options.fetch(:footer_button_text) { "Close" },
        footer_include_cancel_button: options.fetch(:footer_include_cancel_button) { false },
        footer: options.fetch(:footer) { true },
        open_on_page_load: options.fetch(:open_on_page_load) { false },
        set_cookie: options.fetch(:set_cookie) { false },
      }
  end

  def custom_modal_with_header(options, &block)
    header = modal_header(options)

    render partial: 'modals/custom_modal_with_header',
      locals: {
        header: options.fetch(:header) { true },
        header_close_button: options.fetch(:header_close_button) { true },
        modal_id: options.fetch(:modal_id) { "generic-modal" },
        modal_class: options.fetch(:modal_class) { "" },
        modal_header: header,
        modal: capture(&block),
        open_on_page_load: options.fetch(:open_on_page_load) { false },
        set_cookie: options.fetch(:set_cookie) { false },
      }
  end

  def modal_header(options)
    header = []
    if options[:header_icon]
      header << "<span class='icon-cpp #{options[:header_icon]} icon-primary'></span>"
    end
    header << options.fetch(:header_text) { "Generic Modal" }

    header.join("\n").html_safe
  end

  def link_to_modal(text, modal_id, options={})
    link_to text, modal_id, class: "modal-link #{options.delete(:class)}"
  end

  def link_to_modal_with_icon(text, modal_id, options = {})
    icon_class = options.delete(:icon)

    raise ":icon required for link_to_modal_with_icon" unless icon_class

    link_to_modal("#{icon(icon_class)} #{text}".html_safe, modal_id, options)
  end

  def link_to_modal_with_gicon(text, modal_id, options = {})
    icon_class = options.delete(:icon)

    raise ":icon required for link_to_modal_with_icon" unless icon_class

    link_to_modal("#{gicon(icon_class)} #{text}".html_safe, modal_id, options)
  end

  def modal_javascript(modal_id, options={})
    content_for :modal_javascript do
      html = <<-HTML
        <script type='text/javascript'>
          var MODAL = {
            modalTarget: '##{modal_id}',
            setCookie: #{options.fetch(:set_cookie){false}}
          };
        </script>
      HTML

      html.html_safe
    end
  end
end
