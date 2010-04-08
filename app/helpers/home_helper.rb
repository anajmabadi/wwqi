module HomeHelper
  def which_script?
    if I18n.locale == :fa
      return %{
      <script language="javascript" type="application/javascript">
	$(document).ready(function(){

		 $('.slide-wrap').cycle({
		fx: 'fade' // choose your transition type, ex: fade, scrollUp, shuffle, etc...
		});

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

	});
	</script>
      }
    else
      return %{
      <script language="javascript" type="application/javascript">
	$(document).ready(function(){

		$('.slide-wrap').cycle({
		fx: 'fade' // choose your transition type, ex: fade, scrollUp, shuffle, etc...
		});

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


	});
	</script>
      }
    end
  end
end
