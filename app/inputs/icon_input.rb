class IconInput < SimpleForm::Inputs::CollectionInput
  include ActionView::Context
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  def input
    tag = ActionView::Helpers::InstanceTag.new object_name, attribute_name, template, nil
    class << tag
      def id(options)
        options = options.stringify_keys
        options = DEFAULT_FIELD_OPTIONS.merge(options)
        add_default_name_and_id(options)
        options['id']
      end
    end
    tag.to_input_field_tag('hidden', input_options) + controller(tag)
  end

  def controller(tag)
    id = tag.id(input_options)
    content_tag :dvi, :class => :'btn-group' do
      content_tag(:a, :class => [:btn, :'drowdown-toggle'], :data => {toggle: 'dropdown'}) do
        content_tag(:i, nil, :id => "#{id}_front", :class => "icon-#{tag.value(object)}") + ' ' +
        content_tag(:span, nil, :class => :caret)
      end + content_tag(:ul, :class => :'dropdown-menu') do
        collection.map do |item|
          content_tag :li do
            content_tag :a, onclick: "event.preventDefault();document.getElementById('#{id}').setAttribute('value', '#{item}');document.getElementById('#{id}_front').setAttribute('class', 'icon-#{item}');" do
              content_tag :i, nil, :class => "icon-#{item}"
            end
          end
        end.join(' ').html_safe
      end
    end
  end
end
