$(function() {
  var IssueOrdering = {
    initialize: function() {
      $(".backlog-sortable").sortable({
        connectWith: ".backlog-connected",
        placeholder: "backlog-placeholder-element",
        receive: function(event, ui) {
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
        }
      }).disableSelection();
    }
  }

  IssueOrdering.initialize();

  window.IssueOrdering = IssueOrdering;
});
