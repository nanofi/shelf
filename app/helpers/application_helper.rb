module ApplicationHelper
  def default_meta_tags
    {
      site: I18n.t('defaults.site')
    }
  end
  def disabled_current(path)
    return 'disabled' if current_page?(path)
  end
end
