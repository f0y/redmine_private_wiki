ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.private_wiki_change_privacy 'wiki/:id/change_privacy/:private', :controller => 'wiki', :action => 'change_privacy',  :conditions => {:method => :post}
  end
end