(function($) {

  var Sorting = Cell.create('Sorting');

  Sorting.prototype.initialize = function() {
    var _this = this;

    _this.form = _this.$target.find("form");

    _this.$target.on("change", ":input", function() {
      Backlog.instances[0].refresh();
    });
  };

  Sorting.prototype.options = function() {
    var _this = this;
    return _this.form.formParams()["sorting"];
  };
})(jQuery);
