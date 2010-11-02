$(document).ready(function(){

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
        //updateFilterLabels();
        $("#archive_browse_filter").submit();
        return false;
    });

    // this function sets the filter labels based on what checkboxes are selected
    updateFilterLabels();

});



updateFilterLabels = function(){

    var genreLabel, collectionLabel, periodLabel;

    // first handle All case
    if ($("#genreFilter .selectAll input").attr("checked")==true){
        genreLabel = "<%= t(:all) %>";
    }
    // if only one filter is checked, show that label
    else if ($(".genreFilterList input:checked").length==1){
        genreLabel = $(".genreFilterList input:checked").next("label").first().html();
    }
    // else, if multiple filters are selected, just show 'multiple'
    else if ($(".genreFilterList input:checked").length>1){
        genreLabel = "<%= t(:multiple) %>"
    }



    if ($("#collectionFilter .selectAll input").attr("checked")==true){
        collectionLabel = "<%= t(:all) %>";
    }
    else if ($(".collectionFilterList input:checked").length==1){
        collectionLabel = $(".collectionFilterList input:checked").next("label").first().html();
    }
    else if ($(".collectionFilterList input:checked").length>1){
        collectionLabel = "<%= t(:multiple) %>"
    }


    if ($("#periodFilter .selectAll input").attr("checked")==true){
        periodLabel = "<%= t(:all) %>";
    }
    else if ($(".periodFilterList input:checked").length==1){
        periodLabel = $(".periodFilterList input:checked").next("label").first().html();
    }
    else if ($(".periodFilterList input:checked").length>1){
        periodLabel = "<%= t(:multiple) %>"
    }

}
