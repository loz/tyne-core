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

    $(window).bind("popstate", function() {
      if (event.state && event.state.sorting) {
        _this.refresh(false, event.state);
        Sorting.instances[0].resetState(event.state);
        Filter.instances[0].resetState(event.state);
      }
    });
  };

  Backlog.prototype.refresh = function(updateHistory, data) {
    var _this = this;

    var sorting = Sorting.instances[0];
    var filter = Filter.instances[0];

    LoadingIndicator.addTo(".issue-list");

    if (!data) {
      var data = {
        sorting: sorting.options(),
      filter: filter.options()
      }
    }

    var options = {
      data: data,
      success: function(data) {
        _this.list.html(data);
      }
    };

    if (updateHistory) {
      var baseUrl = document.URL.substring(0, document.URL.indexOf("?"));
      var params = $.param(data);
      var decoded = decodeURIComponent(params);
      history.pushState(data, null, baseUrl + "?" + decoded)
    }

    $.ajax(_this.url, options);
  };

  $(function() {
    var sorting = Sorting.instances[0];
    var filter = Filter.instances[0];

    history.replaceState({ sorting: sorting.options(), filter: filter.options() });
  });
})(jQuery);
