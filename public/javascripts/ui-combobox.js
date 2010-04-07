/*
* jQuery widget to create themable dropdownlists
* 
* http://www.jordivila.net/jquery-dropdownlist-widget-json-to-combo-box.html
*
*/

(function($) {

    $.widget("jv.combobox", {
        options: {
            list: null
        }
        , _create: function() {

            var w = this;
            var $el = $(this.element);
            var o = w.options;

            var inHtml = '<div class="ui-combobox-toggle"><a class="ui-combobox-toggleText" href="javascript:void(0);"></a><span class="ui-icon ui-icon-triangle-1-s"></span></div><ul class="ui-combobox-list ui-widget-content ui-corner-all">';
            for (var i = 0; i < o.list.length; i++) {
                inHtml += "<li class='ui-state-default " + (o.list[i].selected == true ? "ui-state-active" : "") + "' valueAlt='" + o.list[i].value + "'>" + o.list[i].text + "</li>";
            }
            inHtml += "</ul>";

            $el.addClass('ui-widget ui-combobox ')
                .append(inHtml)
                .find('ul.ui-combobox-list')
                    .css('width', parseInt($el.css('width')) - 2)
                .end()
                .find('li')
                    .hover(function() { $(this).addClass('ui-state-hover'); }, function() { $(this).removeClass('ui-state-hover'); })
                    .click(function(e) {
                        var bChanged = false;
                        var $sel = $el.find('li.ui-state-active');
                        if (($sel.length == 0) || ($sel.attr('valueAlt') != $(this).attr('valueAlt'))) {
                            w._trigger('changed', null, { value: $(this).attr('valueAlt') });
                            $sel.removeClass('ui-state-active');
                            $(this).addClass('ui-state-active');
                            $el
                                .find('a.ui-combobox-toggleText')
                                    .html($(this).text())
                                .end()
                                .find('div.ui-combobox-toggle')
                                    .click()
                                    .hover();
                        }
                        return false;
                    })
                .end()
                .find('div.ui-combobox-toggle')
                    .mouseover(function() { $(this).addClass('ui-widget-content ui-corner-all ui-state-hover').find('span.ui-icon').show(); })
                    .mouseout(
                                function() {
                                        $(this).removeClass('ui-widget-content ui-corner-all ui-state-hover').find('span.ui-icon').hide();
                                }
                    )
                    .click(function(e) {
                        $el
                            .find('ul.ui-combobox-list')
                                .toggle(1)
                            .end()
                            .find('span.ui-icon')
                                .toggleClass('ui-icon-triangle-1-s ui-icon-triangle-1-n');
                        return false;
                    })
                    .find('span.ui-icon')
                        .css('left', parseInt($el.width()) - 25);

            if ($el.find('li.ui-state-active:first').length == 0) {
                $el.find('a.ui-combobox-toggleText').html($el.find('li:first').text());
            }
            else {
                $el.find('a.ui-combobox-toggleText').html($el.find('li.ui-state-active:first').text());
            }
        },
        destroy: function() {
            $(this.element).find('*').remove();
            $.Widget.prototype.destroy.call(this);
        }
    });

})(jQuery);
