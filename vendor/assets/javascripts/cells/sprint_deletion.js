(function($) {
  var SprintDeletion = Cell.create('SprintDeletion');

  SprintDeletion.prototype.initialize = function() {
    this.$button = this.$target.find('.delete-sprint');

    this.initializeEventHandlers();
  };

  SprintDeletion.prototype.initializeEventHandlers = function() {
    var _this = this;

    this.$button.on('ajax:success', function() { return _this.onDestroy(); });
  };

  SprintDeletion.prototype.onDestroy = function(url) {
    var _this = this;

    _this.$target.remove();

    return false;
  };
})(jQuery);
