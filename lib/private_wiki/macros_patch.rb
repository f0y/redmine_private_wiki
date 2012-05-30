module PrivateWiki
  module MacrosPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :macro_include, :private_wiki
      end
    end

    module InstanceMethods
      def macro_include_with_private_wiki(obj, args)
        page = Wiki.find_page(args.first.to_s, :project => @project)
        if !page.nil? and page.present? and page.private? and not User.current.allowed_to?(:view_private_wiki_pages, page.wiki.project)
          raise 'Access to page is denied'
        end
        macro_include_without_private_wiki(obj, args)
      end
    end
  end
end