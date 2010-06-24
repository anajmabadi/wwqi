module ArchiveHelper
  def header_content
    return s = %{
    <link href="/stylesheets/dd<%= language_suffix -%>.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="/javascripts/uncompressed.jquery.dd.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/stylesheets/facebox<%= language_suffix -%>.css" media="screen" />
    <script type="text/javascript" src="/javascripts/facebox.js" ></script>

    <script language="javascript" type="application/javascript">
      $(document).ready(function(){

      // click events for handling proper css classes sort buttons (A-Z / Date)
      $(".AZsort").click(function(){
      $(".AZsort").parent().siblings().removeClass("active");
      $(".AZsort").parent().addClass("active");
      $(".AZsort").parent().siblings().find("span").removeClass("up");
      $(".AZsort").find("span").toggleClass("up");
      return false;
      });

      $(".dateSort").click(function(){
      $(".dateSort").parent().siblings().removeClass("active");
      $(".dateSort").parent().addClass("active");
      $(".dateSort").parent().siblings().find("span").removeClass("up");
      $(".dateSort").find("span").toggleClass("up");
      return false;
      });

      // click events for handling propper css classes on "all items"/"my items" buttons
      $(".types li a").click(function(){
      $(this).parent().siblings().removeClass("active");
      $(this).parent().addClass("active");

      return false;
      });

      // fancy dropdowns for filters, and handling special cases
      $("#mediumFilter").msDropDown();
      $("#mediumFilter").change(function(){
      if ($(this).val() =="more") $("#browserFiltersDropdown").show("slide");
      else   $("#browserFiltersDropdown").hide("slide");
      });

      $("#browserFiltersDropdown .cancelButton ").click(function(){$("#browserFiltersDropdown").hide("slide");});

      $("#collectionFilter").msDropDown();
      $("#collectionFilter").change(function(){
      if ($(this).val() =="more") window.location = "generic.html"
      });
      $("#nameFilter").msDropDown();
      $("#nameFilter").change(function(){
      if ($(this).val() =="more") window.location = "generic.html"
      });
      $("#subjectFilter").msDropDown();
      $("#periodFilter").msDropDown();


      // tooltips
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

      // thumbnails in grid mode
      $('a[rel*=facebox]').facebox({
      loading_image : '/images/loading.gif',
      close_image   : '/images/closelabel.gif'
      })


      });
    </script>
    }
  end
end
