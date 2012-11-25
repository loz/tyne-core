(function($) {

  var Filter = Cell.create('Filter');

  Filter.prototype.initialize = function() {
    var _this = this;

    _this.form = _this.$target.find("form");

    _this.$target.on("change", ":input", function() {
      var _target = $(event.target);
      var _filterOption = _target.closest(".filter");
      _filterOption.find(".selected").removeClass("selected");
      _filterOption.find('[for="' + event.target.id + '"]').addClass("selected");
      Backlog.instances[0].refresh();
    });
  };

  Filter.prototype.options = function() {
    var _this = this;
    return _this.form.formParams()["filter"];
  };
})(jQuery);
