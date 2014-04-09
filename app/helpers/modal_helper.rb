module ModalHelper

  def modal(type, options={}, &block)
    case type
    when :basic
      basic_modal(options, &block)
    when :with_button
      modal_with_button(options, &block)
    end
  end

  def basic_modal(options, &block)
    header = modal_header(options)

    render partial: 'modals/basic_modal',
      locals: {
        header: options.fetch(:header) { true },
        modal_id: options.fetch(:modal_id) { "generic-modal" },
        modal_class: options.fetch(:modal_class) { "" },
        modal_header: header,
        modal_body: capture(&block),
        footer: options.fetch(:footer) { true },
      }
  end

  def modal_with_button(options, &block)
    header = modal_header(options)

    render partial: 'modals/modal_with_button',
      locals: {
        header: options.fetch(:header) { true },
        modal_id: options.fetch(:modal_id) { "generic-modal" },
        modal_class: options.fetch(:modal_class) { "" },
        modal_header: header,
        modal_body: capture(&block),
        footer_button_class: options.fetch(:footer_button_class) { "btn-primary" },
        footer_button_text: options.fetch(:footer_button_text) { "Close" },
        footer: options.fetch(:footer) { true },
      }
  end

  def modal_header(options)
    header = []
    if options[:header_icon]
      header << "<span class='icon-cpp #{options[:header_icon]}'></span>"
    end
    header << options.fetch(:header_text) { "Generic Modal" }

    header.join("\n").html_safe
  end
end
