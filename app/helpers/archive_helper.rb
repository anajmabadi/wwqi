module ArchiveHelper
  
  def archive_column_style
    if I18n.locale == :fa
       style = "width:100px; right:0"
    else
      style ="width:100px; left:0"
    end
    return style
  end
  
  def index_header_content
    return %{
      <script src="javascripts/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script> 
      <script type="text/javascript" src="javascripts/facebox.js"></script>

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
    									 target: 'bottomMiddle',
    									 tooltip: 'topMiddle'
    								  }
    						   		} 
    		}); 
    		
    		$("#mediaTypes .column").hover(function(){

            $(this).addClass("hover");
            $('ul',this).css('visibility', 'visible');

    		}, function(){

    			$(this).removeClass("hover");
    			$('ul',this).css('visibility', 'hidden');

    		});

    		$(".featuredCollection a.next").click(function(){
    			$(".collectionContainerWrapper").animate({"scrollLeft":"+="+261 +"px"},200);
    			return false;
    		});
    		$(".featuredCollection a.prev").click(function(){
    			$(".collectionContainerWrapper").animate({"scrollLeft":"-=" + 261 +"px"},200);
    			return false;
    		});


    	});
    	</script>
    }
  end
  
  def browser_header_content
    return %{
    <link href="/stylesheets/dd<%= language_suffix -%>.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="/javascripts/uncompressed.jquery.dd.js" type="text/javascript"></script>
    <script src="/javascripts/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script> 

  	<script language="javascript" type="application/javascript">
  	$(document).ready(function(){
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
  			$(this).find('a.title').animate({"bottom":"0px"},200);
  		}, function(){
  			$(this).find('a.title').animate({"bottom":"-20px"},200);							
  		});

  		$("#indexLinks a").click(function(){

  			// if use is clicking on an already active index, then most likely they 
  			// want to close the index panel
  			if ($(this).hasClass('active')){
  				$("#browserFiltersDropdown").slideUp();
  				$(this).removeClass('active').parent().removeClass('active');
  			}

  			// if user clicks on an index that's not already active, then give the clicked link
  			// the 'active' class, and if necessary open the index panel
  			else {
  				$(this).parent().siblings().removeClass('active').find('a').removeClass('active');
  				$(this).addClass('active').parent().addClass('active');
  				// show the appropriate index list
					var showMe = $(this).attr("id")+"Content";
					$(".indexContent").hide();
					$("."+showMe).show();

				if ($("#browserFiltersDropdown").css('display')=='none'){
  					$("#browserFiltersDropdown").slideDown();

  				}

  			}
  			return false;
  		});

  		$(".hideIndexPanel").click(function(){
  			$("#browserFiltersDropdown").slideUp();
  			$("#indexLinks a").removeClass('active').parent().removeClass('active');
  			return false;
  		});


  	});
  	</script>
    }
  end

  def archive_grid_header
    return s = %{
        <link href="/stylesheets/dd.css" media="screen" rel="stylesheet" type="text/css" />
        <script type="application/javascript" language="javascript" src="/javascripts/jquery-1.4.min.js"></script>
        <script src="/javascripts/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
        <script src="/javascripts/uncompressed.jquery.dd.js" type="text/javascript"></script>

        <script language="javascript" type="application/javascript">
          $(document).ready(function(){
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
          $(this).find('a.title').animate({"bottom":"0px"},200);
          }, function(){
          $(this).find('a.title').animate({"bottom":"-20px"},200);
          });
          $("#indexLinks a").click(function(){

      			// if use is clicking on an already active index, then most likely they 
      			// want to close the index panel
      			if ($(this).hasClass('active')){
      				$("#browserFiltersDropdown").slideUp();
      				$(this).removeClass('active').parent().removeClass('active');
      			}

      			// if user clicks on an index that's not already active, then give the clicked link
      			// the 'active' class, and if necessary open the index panel
      			else {
      				$(this).parent().siblings().removeClass('active').find('a').removeClass('active');
      				$(this).addClass('active').parent().addClass('active');
      					// show the appropriate index list
					var showMe = $(this).attr("id")+"Content";
					$(".indexContent").hide();
					$("."+showMe).show();

				if ($("#browserFiltersDropdown").css('display')=='none'){
      					$("#browserFiltersDropdown").slideDown();	
      				}

      			}
      			return false;
      		});

      		$(".hideIndexPanel").click(function(){
      			$("#browserFiltersDropdown").slideUp();
      			$("#indexLinks a").removeClass('active').parent().removeClass('active');
      			return false;
      		});
          });
      		
        </script>
    }
  end

  def archive_list_header
    return s = %{
        <link href="/stylesheets/dd.css" media="screen" rel="stylesheet" type="text/css" />
        <script src="/javascripts/uncompressed.jquery.dd.js" type="text/javascript"></script>
        <script language="javascript" type="application/javascript">
          $(document).ready(function(){

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

      		$("#indexLinks a").click(function(){

      			// if use is clicking on an already active index, then most likely they 
      			// want to close the index panel
      			if ($(this).hasClass('active')){
      				$("#browserFiltersDropdown").slideUp();
      				$(this).removeClass('active').parent().removeClass('active');
      			}

      			// if user clicks on an index that's not already active, then give the clicked link
      			// the 'active' class, and if necessary open the index panel
      			else {
      				$(this).parent().siblings().removeClass('active').find('a').removeClass('active');
      				$(this).addClass('active').parent().addClass('active');
      					// show the appropriate index list
					var showMe = $(this).attr("id")+"Content";
					$(".indexContent").hide();
					$("."+showMe).show();

				if ($("#browserFiltersDropdown").css('display')=='none'){
      					$("#browserFiltersDropdown").slideDown();
      				}

      			}
      			return false;
      		});

      		$(".hideIndexPanel").click(function(){
      			$("#browserFiltersDropdown").slideUp();
      			$("#indexLinks a").removeClass('active').parent().removeClass('active');
      			return false;
      		});
          });
          
     
        		
          
        </script>
    }
  end

  def archive_slideshow_header
    return s = %{
        <link href="/stylesheets/dd.css" media="screen" rel="stylesheet" type="text/css" />
        <script type="application/javascript" language="javascript" src="/javascripts/jquery-1.4.min.js"></script>
        <script src="/javascripts/jquery.qtip-1.0.0-rc3.min.js" type="text/javascript"></script>
        <script src="/javascripts/uncompressed.jquery.dd.js" type="text/javascript"></script>
        <script language="javascript" type="application/javascript">
          $(document).ready(function(){

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



          $(".slideshow_container .next").click(function(){
          $(".slideshow").animate({left: '-=' + 190 + 'px'});
          return false;
          });
          $(".slideshow_container .prev").click(function(){
          $(".slideshow").animate({left: '+=' + 190 + 'px'});
          return false;
          });
          $("#indexLinks a").click(function(){

      			// if use is clicking on an already active index, then most likely they 
      			// want to close the index panel
      			if ($(this).hasClass('active')){
      				$("#browserFiltersDropdown").slideUp();
      				$(this).removeClass('active').parent().removeClass('active');
      			}

      			// if user clicks on an index that's not already active, then give the clicked link
      			// the 'active' class, and if necessary open the index panel
      			else {
      				$(this).parent().siblings().removeClass('active').find('a').removeClass('active');
      				$(this).addClass('active').parent().addClass('active');
					// show the appropriate index list
					var showMe = $(this).attr("id")+"Content";
					$(".indexContent").hide();
					$("."+showMe).show();
      				if ($("#browserFiltersDropdown").css('display')=='none'){
      					$("#browserFiltersDropdown").slideDown();
					
      				}

      			}
      			return false;
      		});

      		$(".hideIndexPanel").click(function(){
      			$("#browserFiltersDropdown").slideUp();
      			$("#indexLinks a").removeClass('active').parent().removeClass('active');
      			return false;
      		});

          });
          

      		
        </script>
    }
  end
end
