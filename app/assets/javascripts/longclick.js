(function($) {
  $.fn.longClick = function(callback, timeout) {
    var timer;
    timeout = timeout || 500;
    $(this).mousedown(function(event) {
      timer = setTimeout(function() { callback(event); }, timeout);
      return false;
    });
    $(document).mouseup(function(event) {
      clearTimeout(timer);
      return false;
    });
  };

})(jQuery);
