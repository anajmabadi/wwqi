$(document).ready(function(){

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

    $(".listItem").hover(function(){
        $(this).addClass("highlight");
    },
    function(){
        $(this).removeClass("highlight");
    });

    $(".listItem").click(function(){
        window.location=$(this).find("a:first-child").attr("href");
    })
			
    // everything below this is new js

    // adding 'hover' class to filters header (don't want to rely on css :hover since it doesn't work on all browsers
    $("#head.filters").hover(function(){
        $(this).addClass("over");
    }
    ,function(){
        $(this).removeClass("over");
    });

    $("#filterOptions a").click(function(){
        $("#filtersPanel").slideToggle();
        $("#filterStatus").toggleClass("open");
    })

    // making sure when 'all' checkbox is selected we deselect the others
    $(".selectAll input").click(function(){
        if ($(this).attr("checked")==true){
            $(this).parent().parent().siblings().find("input").removeAttr("checked");
        }


    });

    // if a normal item in the checklist is selected, unselect the 'all' checkbox for that list
    $(".genreFilterList input").click(function(){
        if ($(this).attr("checked")==true){
            $(this).parent().parent().siblings().find("input").removeAttr("checked");
        }
        // if none of the checkboxes in the list are selected, then select the 'all' checkbox
        if ($(this).parent().parent().find("input:checked").length<1){
            $(this).parent().parent().siblings().find("input").attr("checked",true);
        }

    });
    $(".collectionFilterList input").click(function(){
        if ($(this).attr("checked")==true){
            $(this).parent().parent().siblings().find("input").removeAttr("checked");
        }
        if ($(this).parent().parent().find("input:checked").length<1){
            $(this).parent().parent().siblings().find("input").attr("checked",true);
        }

    });
    $(".periodFilterList input").click(function(){
        if ($(this).attr("checked")==true){
            $(this).parent().parent().siblings().find("input").removeAttr("checked");
        }
        if ($(this).parent().parent().find("input:checked").length<1){
            $(this).parent().parent().siblings().find("input").attr("checked",true);
        }

    });


    $("#cancelFilters").click(function(){
        $("#filtersPanel").slideToggle();
        return false;
    });

    $("#submitFilters").click(function(){
        $("#filtersPanel").slideToggle();
        updateFilterLabels();
        return false;
    });

    // this function sets the filter labels based on what checkboxes are selected
    updateFilterLabels();

});



updateFilterLabels = function(){

    var genreLabel, collectionLabel, periodLabel;

    // first handle All case
    if ($("#genreFilter .selectAll input").attr("checked")==true){
        genreLabel = "All";
    }
    // if only one filter is checked, show that label
    else if ($(".genreFilterList input:checked").length==1){
        genreLabel = $(".genreFilterList input:checked").next("label").first().html();
    }
    // else, if multiple filters are selected, just show 'multiple'
    else if ($(".genreFilterList input:checked").length>1){
        genreLabel = "Multiple"
    }



    if ($("#collectionFilter .selectAll input").attr("checked")==true){
        collectionLabel = "All";
    }
    else if ($(".collectionFilterList input:checked").length==1){
        collectionLabel = $(".collectionFilterList input:checked").next("label").first().html();
    }
    else if ($(".collectionFilterList input:checked").length>1){
        collectionLabel = "Multiple"
    }


    if ($("#periodFilter .selectAll input").attr("checked")==true){
        periodLabel = "All";
    }
    else if ($(".periodFilterList input:checked").length==1){
        periodLabel = $(".periodFilterList input:checked").next("label").first().html();
    }
    else if ($(".periodFilterList input:checked").length>1){
        periodLabel = "Multiple"
    }


    // set the labels
    $("#byGenre span").html(genreLabel);
    $("#byCollection span").html(collectionLabel);
    $("#byPeriod span").html( periodLabel);


}
