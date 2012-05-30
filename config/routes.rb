RedmineApp::Application.routes.draw do
  match 'projects/:project_id/wiki/:id/change_privacy/:private', :controller => 'wiki', :action => 'change_privacy', :via => [:post]
end