$(function() {
  var IssueOrdering = {
    initialize: function() {
      $(".backlog-sortable").sortable({
        connectWith: ".backlog-connected",
        placeholder: "backlog-placeholder-element"
      }).disableSelection();
    }
  }

  IssueOrdering.initialize();

  window.IssueOrdering = IssueOrdering;
});
