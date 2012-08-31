$ ->
  $("#new_project_link").click ->
    resource_url = $("#project_dialog form").data("resource-url")
    $("#project_dialog form").attr("action", resource_url)
    $("#project_dialog form input[name=_method]").val("post")
    $("#project_dialog form").populate({})
    options =
      success: (responseText, status, xhr) ->
        $("table.projects tbody").append(responseText)
        $("#project_dialog").dialog('close')
    $("#project_dialog form").ajaxForm(options)

  $(".projects tbody").on "click", "tr", (event) ->
    return if event.target.className == "destroy"
    $project = $(@)
    resource_url = $("#project_dialog form").data("resource-url")
    data = $(@).data("serialized")
    edit_url = resource_url + "/" + data.id
    $("#project_dialog form").attr("action", edit_url)
    $("#project_dialog form input[name=_method]").val("put")
    $("#project_dialog form").populate(project: data)
    options =
      success: (responseText, status, xhr) ->
        $project.replaceWith(responseText)
        $("#project_dialog").dialog('close')
    $("#project_dialog form").ajaxForm(options)

  $(".projects tbody").on "click", "tr .destroy", (event) ->
    $project = $(event.target).closest("tr")
    resource_url = $("#project_dialog form").data("resource-url")
    data = $project.data("serialized")
    delete_url = resource_url + "/" + data.id
    $.post delete_url, _method: "delete", (data, textStatus, jqXHR) ->
      $project.remove()
