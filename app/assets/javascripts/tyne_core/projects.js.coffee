class @ProjectGrid
  constructor: (@target) ->
    @link = $(@target).find(".new_link").first
    @dialog = $(@target).find(".modal").first
    @form = $(@dialog).find("form").first
    @grid = $(@target).find(".grid").first

    @resourceUrl = $(@form).data("resource-url")

    $(@link).on "click", @.toNewForm
    $(@grid).on "click", @.toUpdateForm
    $(@grid).on "click", "tr .destroy", @.destroy

  toNewForm: (event) =>
    $(@form).attr("action", @resourceUrl)
    @.setMethod("post")
    @.populateForm({})
    options =
      success: (responseText, status, xhr) ->
        $(@grid).find("tbody").append(responseText)
        $(@dialog).dialog('close')
    @.makeAjaxForm(options)

  toUpdateForm: (event) =>
    return if event.target.className == "destroy"
    $project = $(@)
    data = $(@).data("serialized")
    edit_url = @resourceUrl + "/" + data.id
    $(@form).attr("action", edit_url)
    self.setMethod("put")
    @.populateForm(project: data)
    options =
      success: (responseText, status, xhr) ->
        $project.replaceWith(responseText)
        $(@dialog).dialog('close')
    $(@form).ajaxForm(options)

  setMethod: (method) ->
    $(@form).find("input[name=_method]").val(method)

  populateForm: (data) =>
    $(@form).populate(data)

  makeAjaxForm: (options) ->
    $(@form).ajaxForm(options)

  destroy: (event) ->
    $project = $(event.target).closest("tr")
    data = $project.data("serialized")
    delete_url = @resourceUrl + "/" + data.id
    $.post delete_url, _method: "delete", (data, textStatus, jqXHR) ->
      $project.remove()
