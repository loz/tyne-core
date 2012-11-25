(function($) {

  var Filter = Cell.create('Filter');

  Filter.prototype.initialize = function() {
    var _this = this;

    _this.form = _this.$target.find("form");

    _this.$target.on("click", "label", function() {
      event.preventDefault();

      var _label = $(event.target);
      var _filter = _label.closest(".filter");
      var _option = _label.closest(".filter-options");
      var _input = _option.find("input");
      var _link = _option.find("a");

      _filter.find(".icon-remove").removeClass("icon-remove").addClass("icon-plus");
      _filter.find(":input").not(_input).removeAttr("checked");
      _filter.find(".selected").removeClass("selected");
      _input.attr("checked", "checked");

      _option.addClass("selected");
      _link.removeClass("icon-plus").addClass("icon-remove");

      Backlog.instances[0].refresh();
    });

    _this.$target.on("click", ".filter-add", function() {
      event.preventDefault();

      var _target = $(event.target);
      var _filter = _target.closest(".filter");
      var _filterOption = _target.closest(".filter-options");
      var _input = _filterOption.find("input");
      var _all = _filter.find('[id*=_all]').closest(".filter-options");
      var _selected = _filterOption.is(".selected");

      if (_selected) {
        // Remove filter
        _input.removeAttr("checked");
        _target.removeClass("icon-remove").addClass("icon-plus");
        _filterOption.removeClass("selected");

        // Select all if no filter is applied
        if (_filter.find('input:checked').length == 0) {
          _all.addClass("selected");
        }
      } else {
        // Add filter
        _all.removeClass("selected");
        _input.attr("checked", "checked");
        _target.removeClass("icon-plus").addClass("icon-remove");
        _filterOption.addClass("selected");
      };

      Backlog.instances[0].refresh();
    });
  };

  Filter.prototype.options = function() {
    var _this = this;
    return _this.form.formParams()["filter"];
  };
})(jQuery);
