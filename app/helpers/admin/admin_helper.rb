module Admin::AdminHelper
  def admin_head_content
    return %{
      <!-- hello -->
      #{ javascript_include_tag 'fancybox/jquery.fancybox-1.3.1.pack.js' }
      #{ javascript_include_tag 'jwysiqyg/jquery.wysiwyg.js' }
      #{ javascript_include_tag 'hint.js' }
      #{ javascript_include_tag 'jquery.visualize.js' }
      #{ javascript_include_tag 'jquery.tipsy.js' }
      #{ javascript_include_tag 'browser.js' }
      #{ javascript_include_tag 'custom.js' }

      #{ stylesheet_link_tag 'admin/screen.css', :media => 'screen' }
      #{ stylesheet_link_tag 'admin/datepicker.css', :media => 'screen' }
      #{ stylesheet_link_tag 'admin/tipsy.css', :media => 'screen' }
      #{ stylesheet_link_tag 'admin/visualize.css', :media => 'screen' }
      #{ stylesheet_link_tag '/javascripts/fancybox/jquery.fancybox-1.3.1.css', :media => 'screen' }
    }
  end
end
