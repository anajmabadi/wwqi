module ApplicationHelper

  def language_suffix
    '_fa' if I18n.locale == :fa
  end

  def language_url
    # TODO: Make this context sensitive -- hard coded for development
    if I18n.locale == :fa
      return 'http://en.qajar.local'
    else
      return 'http://fa.qajar.local'
    end
  end

  def add_this_block
    s = %{
    <!-- AddThis Button BEGIN -->
    <script type="text/javascript">var addthis_pub="mesolore";</script>
    <a href="http://www.addthis.com/bookmark.php"
            onmouseover="return addthis_open(this, '', '[URL]', '[TITLE]');"
            onmouseout="addthis_close();"
            onclick="return addthis_sendto();">#{t(:share)}</a>
    <script type="text/javascript" src="http://s7.addthis.com/js/200/addthis_widget.js"></script>
    <!-- AddThis Button END -->
    }
  end

  def which_script?
    if I18n.locale == :fa
      return %{
      <script language="javascript" type="application/javascript">
      $(document).ready(function(){

        $('a[title]').qtip({
                       style: {
                     name: 'dark',
                     tip: true,
                      border: {
                         radius: 8
                        }
                    },
                     position: {
                      corner: {
                       target: 'topMiddle',
                       tooltip: 'bottomMiddle'
                      }
                      }
        });

        $('.item').hover(function(){
          $(this).find('a').animate({"bottom":"0px"},200);
        }, function(){
          $(this).find('a').animate({"bottom":"-20px"},200);
        });

        $("#firstFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '1950px'}, 300);
          return false;
        });
        $("#secondFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '1300px'}, 300);
          return false;
        });
        $("#thirdFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '650px'}, 300);
          return false;
        });
        $("#fourthFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '0px'}, 300);
          return false;
        });
        $('a[rel*=facebox]').facebox({
            loading_image : '../images/loading.gif',
            close_image   : '../images/closelabel.gif'
          })

      });
    </script>
      }
    else
      return %{
      <script language="javascript" type="application/javascript">
      $(document).ready(function(){

        $('a[title]').qtip({
          style: {
            name: 'dark',
            tip: true,
            border: {
              radius: 8
            }
          },
          position: {
            corner: {
              target: 'topMiddle',
              tooltip: 'bottomMiddle'
            }
          }
        });

        $('.item').hover(function(){
          $(this).find('a').animate({"bottom":"0px"},200);
        }, function(){
          $(this).find('a').animate({"bottom":"-20px"},200);
        });

        $("#firstFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '0px'}, 300);
          return false;
        });
        $("#secondFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '650px'}, 300);
          return false;
        });
        $("#thirdFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '1300px'}, 300);
          return false;
        });
        $("#fourthFeature").click(function(){
          $(".dots a").removeClass("active");
          $(this).addClass("active");
          $("#featuredContent").animate({scrollLeft: '1950px'}, 300);
          return false;
        });
        $('a[rel*=facebox]').facebox({
          loading_image : 'images/loading.gif',
          close_image   : 'images/closelabel.gif'
        })

      });
    </script>
      }
    end
  end
  def google_analytics_block
    if Rails.env == 'production'
      s = %{
    <!-- Google Analytics BEGIN -->
    <script type="text/javascript">
      var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
      document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript">
      try {
        var pageTracker = _gat._getTracker("UA-1325142-22");
        pageTracker._trackPageview();
      } catch(err) {}
    </script>
    <!-- Google Analytics END -->
      }
    end
  end

  #zoomify javascript include block
  def include_zoomify?
    # check is we are on the source controller and have a valid source stored
    return %{
    <!-- Zoomify swfobject registration BEGIN -->
    <script type="text/javascript">
      swfobject.registerObject("zoomify_swf", "10.0.0", "/flash/expressInstall.swf");
    </script>
    <!-- Zoomify swfobject registration END -->
    } unless @source.nil?
  end

  #fckeditor javascript include block
  def include_fckeditor?
    # check whether we are editing or need the control
    return %{
      javascript_include_tag 'fckeditor/fckeditor.js'
    } if ['edit','new'].include?(controller.action_name) || @use_fckeditor
  end

  TYPO_TAG_KEY = TYPO_ATTRIBUTE_KEY = /[\w:_-]+/
  TYPO_ATTRIBUTE_VALUE = /(?:[A-Za-z0-9]+|(?:'[^']*?'|"[^"]*?"))/
  TYPO_ATTRIBUTE = /(?:#{TYPO_ATTRIBUTE_KEY}(?:\s*=\s*#{TYPO_ATTRIBUTE_VALUE})?)/
  TYPO_ATTRIBUTES = /(?:#{TYPO_ATTRIBUTE}(?:\s+#{TYPO_ATTRIBUTE})*)/
  TAG = %r{<[!/?\[]?(?:#{TYPO_TAG_KEY}|--)(?:\s+#{TYPO_ATTRIBUTES})?\s*(?:[!/?\]]+|--)?>}

  #strip_html
  def strip_html(html_string)
    return html_string.gsub(TAG, '').gsub(/\s+/, ' ').strip
  end

  #blip.tv player
  def blip_player(id)
    return %{
      <!-- blipTV player BEGIN -->
      <embed src="http://blip.tv/play/#{id}" type="application/x-shockwave-flash" width="480" height="390" allowscriptaccess="always" allowfullscreen="true"></embed>
      <!-- blipTV player END -->
    } unless id.nil?
  end
end
