jQuery(document).ready(function () {
    jQuery('.main-sidebar a').click(function(){
        var match = jQuery(this).attr('href').match(/#\S+/);
        ga('send', 'pageview', location.pathname + match[0]);
    });
});
