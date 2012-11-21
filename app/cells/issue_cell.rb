class IssueCell < Cell::Rails
  def create(dialog_path)
    @dialog_path = dialog_path
    render
  end
end
