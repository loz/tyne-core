(function($, exports) {

  Backlog = function(_target) {
    var _this = this;

    _this.$target = $(_target);

    _this.$target.on("click", ".btn-refresh", function() {
      event.preventDefault();

      var url = $(event.target).attr("href");
      var options = {
        success: function(data) {
          _this.$target.find(".issue-list").replaceWith(data);
        }
      };

      $.ajax(url, options);
    });
  }

  exports.Backlog = Backlog;
})(jQuery, window);

$(document).ready(function() {
  $('[data-behaviour="backlog"]').each(function() {
    new Backlog(this);
  });
});
