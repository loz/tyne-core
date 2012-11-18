(function($, exports) {

  CreateIssue = function(_target) {
    var _this = this;

    _this.$target = $(_target);
    _this.urlPattern = null;
    _this.$dialog = function() {
      var dialogs = $("body").find('#issue_dialog');
      if (dialogs.length > 0) {
        return $(dialogs[0]);
      } else {
        return Loader.load(_this.$target.data("dialog"), $("body"), "#issue_dialog");
      }
    };
    _this.$form = function() {
      var form = $(_this.$dialog.call(_this).find("form")[0]);
      if (!_this.urlPattern) _this.urlPattern = form.attr('action');
      return form;
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

    var form = this.$form.call(this);
    form.populate({});

    var options = {
      dataType: 'json',
      success: function(responseText, status, xhr) {
        _this.$dialog.call(_this).modal('hide');
        Notification.showSuccess(I18n.t("flash.actions.create.notice", {resource_name: "Issue"}));
      },
      beforeSubmit: function(arr, $form, options) {
        // Look for project url in selected project
        var key = $form.find("select option:selected").data('key');
        options.url = options.url.replace(':key', key);
      }
    };

    _this.$dialog.call(_this).modal("show");
    form.ajaxForm(options);
  };

  exports.CreateIssue = CreateIssue;
})(jQuery, window);

$(document).ready(function() {
  $(".btn-create-issue").each(function() {
    new CreateIssue(this);
  });
});
