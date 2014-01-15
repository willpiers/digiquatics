class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  FORM_HELPERS = %w{text_field password_field email_field select}

  delegate :content_tag, to: :@template
  delegate :label_tag, to: :@template

  def standard_html type, method, options = {}
    options[:class] ||= ""
    options[:label] ||= method.to_s.titleize
    field_errors = @object.errors[method].join(', ')
      if !@object.errors[method].blank?

    content_tag :div, class: "form-group #{ 'has-error'
      unless @object.errors[method].blank?}" do
      content = label_tag("#{object_name}[#{method}]", "#{options[:label]}",
        :class => "control-label")
      content << @template.send(type+'_tag', "#{object_name}[#{method}]", nil,
        :class => "form-control #{options[:class]}")
      content << (content_tag(:span, field_errors.humanize,
        class: 'help-block')) if field_errors
      content.html_safe
    end
  end

  FORM_HELPERS.each do |method_name|
    define_method(method_name) do |method, *args|
      options = args.extract_options!.symbolize_keys!
      standard_html(__method__.to_s, method, options)
    end
  end
end
