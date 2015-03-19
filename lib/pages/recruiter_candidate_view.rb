require_all 'lib'

class RecruiterCandidateView < SitePrism::Page
  include Helpers

  set_url "/CandidateView.jsp"

  # Actions
  element :action_dropdown, "#candidateaction"
  element :action_submit, "input[name=execute]"

  # History
  element :apply_history_table, "#apply-history-table"
  element :apply_history_table_tbody, "#apply-history-table-tbody"
  element :apply_history_page_position, "#page-range-apply-history-table-body"
  element :apply_history_table_nav_prev, "#nav-prv-apply-history-table-body"
  element :apply_history_table_nav_next, "#nav-next-apply-history-table-body"

  # Adding a note
  element :add_note_textarea, "#note"
  element :add_note_submit, "#add-note"

  # Logs
  element :log_table, "#trans-log-view-table"
  element :apply_log_table_nav_prev, "#nav-prv-transaction-log-table-body"
  element :apply_log_table_nav_next, "#nav-next-transaction-log-table-body"

  # Adding an attachment
  element :attachment_desc_textarea, "#description"
  element :attachment_upload_input,"#file-choose"
  element :attachment_submit, "#upload"

  def submit_action(action)
    action_dropdown.select(action)
    action_submit.click
  end

  def add_note(note)
    add_note_textarea.set note
    add_note_submit.click
  end

end
