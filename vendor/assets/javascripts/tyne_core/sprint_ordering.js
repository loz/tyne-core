$(function() {
  var IssueOrdering = {
    initialize: function() {
      $(".backlog-sortable").sortable({
        connectWith: ".backlog-connected",
        placeholder: "backlog-placeholder-element",
        update: function(event, ui) {
          var list = ui.item.parent();
          var items = list.find("li");
          var newIndex = items.index(ui.item) + 1;

          var url = list.data("reorder-url");
          var options = {
            type: "POST",
            data: {
              issue_id: ui.item.data("id"),
              position: newIndex
            }
          };

          $.ajax(url, options);
        },
        receive: function(event, ui) {
          var senderList = ui.sender;
          var receiverList = ui.item.closest("ul");

          senderList.closest("div").find(".issue-count").text(I18n.t("misc.issue", { count: senderList.find("li").length }));
          receiverList.closest("div").find(".issue-count").text(I18n.t("misc.issue", { count: receiverList.find("li").length }));
      }}).disableSelection();
    }
  }

  IssueOrdering.initialize();

  window.IssueOrdering = IssueOrdering;
});
