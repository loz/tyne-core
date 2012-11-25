(function($) {

  var Backlog = Cell.create('Backlog');

  Backlog.prototype.initialize = function() {
    var _this = this;

    _this.list = _this.$target.find('.issue-list');
    _this.url = _this.$target.find('.btn-refresh').attr("href");

    _this.$target.on("click", ".btn-refresh", function() {
      event.preventDefault();

      _this.refresh();
    });
  };

  Backlog.prototype.refresh = function() {
    var _this = this;

    var sorting = Sorting.instances[0];
    var filter = Filter.instances[0];

    LoadingIndicator.addTo(".issue-list");

    var options = {
      data: {
        sorting: sorting.options(),
        filter: filter.options()
      },
      success: function(data) {
        _this.list.html(data);
      }
    };

    $.ajax(_this.url, options);
  };
})(jQuery);
