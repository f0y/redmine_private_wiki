module PrivateWiki
  class PrivateWikiHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :partial => 'hooks/html_header'
    render_on :view_layouts_base_body_bottom, :partial => 'hooks/body_bottom'
  end
end