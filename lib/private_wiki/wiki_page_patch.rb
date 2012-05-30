module PrivateWiki
  module WikiPagePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        attr_protected :private
        alias_method_chain :visible?, :private_wiki
        #named_scope :nonprivate_only, :conditions => {:private => false}
      end
    end

    module InstanceMethods

      def private_page_visible?(project, user)
        !user.nil? && user.allowed_to?(:view_private_wiki_pages, project)
      end

      def visible_with_private_wiki?(user=User.current)
        allowed = visible_without_private_wiki?(user)
        if allowed and self.private
          return private_page_visible?(project, user)
        end
        allowed
      end

    end
  end
end