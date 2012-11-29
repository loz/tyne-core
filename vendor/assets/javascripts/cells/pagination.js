(function($) {

  var Pagination = Cell.create('Pagination');

  Pagination.prototype.initialize = function() {
    var _this = this;

    _this.page = _this.$target.data("page");
    _this.form = _this.$target.find("form");

    _this.$target.on("click", '[data-pagination="prev"]', function() {
      _this.page--;
      Backlog.instances[0].refresh(true);
    });

    _this.$target.on("click", '[data-pagination="next"]', function() {
      _this.page++;
      Backlog.instances[0].refresh(true);
    });

    _this.$target.on("change", 'select', function() {
      _this.page = 1;
      Backlog.instances[0].refresh(true);
    });
  };

  Pagination.prototype.resetState = function(data) {
  };

  Pagination.prototype.options = function() {
    var _this = this;
    var pagination = _this.form.formParams()["pagination"];
    pagination.page = _this.page;
    console.log("page", pagination.page);

    return pagination;
  };
})(jQuery);
