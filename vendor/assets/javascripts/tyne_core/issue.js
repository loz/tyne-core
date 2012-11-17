(function($, exports) {

  CreateIssue = function(_target) {
    var _this = this;

    _this.$target = $(_target);
    _this.$dialog = function() {
      var dialogs = $("body").find('#issue_dialog');
      if (dialogs.length > 0) {
        return $(dialogs[0]);
      } else {
        return Loader.load(_this.$target.data("dialog"), $("body"));
      }
    };
    _this.$form = function() {
      return $(_this.$dialog.call(_this).find("form")[0]);
    };

    _this.validationEnabled = null;

    _this.attachEvents();
  };

  CreateIssue.prototype.attachEvents = function() {
    var _this = this;

    _this.$target.on("click", function() {
      _this.toNewForm();
    });

    $("body").on("shown", '#issue_dialog', function() {
      if (!_this.validationEnabled) _this.validationEnabled = $(ClientSideValidations.selectors.forms).validate();
    });
  };

  CreateIssue.prototype.toNewForm = function() {
    var _this = this;

    this.$form.call(this).populate({});

    var options = {
      dataType: 'json',
      success: function(responseText, status, xhr) {
        _this.$dialog.call(_this).modal('hide');
        Notification.showSuccess(I18n.t("flash.actions.create.notice", {resource_name: "Issue"}));
      },
      error: function(response, message, statusText) {
        var errors = $.parseJSON(response.responseText);

        console.log("Error");
      }
    };

    _this.$dialog.call(_this).modal("show");
    _this.$form.call(this).ajaxForm(options);
  };

  exports.CreateIssue = CreateIssue;
})(jQuery, window);

$(document).ready(function() {
  $(".btn-create-issue").each(function() {
    new CreateIssue(this);
  });
});
