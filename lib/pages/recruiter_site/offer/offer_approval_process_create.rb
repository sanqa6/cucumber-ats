module RecruiterSite

  class SelectedApproversList < SitePrism::Section
    element :name, "span div"
    element :delete_link, ".remove"
  end

  class ApprovalProcessEditModalConfirm < SitePrism::Section
    element :confirm, ".btn-primary"
    element :cancel, ".btn-cancel"
  end

  class OfferApprovalProcessCreatePage < SitePrism::Page
    include Helpers

    set_url "/recruiter/#!/approval-workflows/create"

    element :backlink, ".navigate-back"
    element :name, "#name"
    element :create_button, ".btn-create-process"
    element :edit_button, ".btn-edit-process"
    sections :approvers, SelectedApproversList, "#selected-approvers li"
    section :confirm_modal, ApprovalProcessEditModalConfirm, "#dialog-region"

    def create
      wait_for_ajax
      create_button.click
      wait_for_ajax
    end

    def edit
      wait_for_ajax
      edit_button.click
      confirm_modal.confirm.click
      wait_for_ajax
    end

    def set_name(value)
      name.set(value)
    end

    def select_approver(value)
      page.find('.select2-chosen', :text=>"Add Approvers").click
      wait_for_ajax
      page.find('.select2-result-label', :text=>"#{value}").click
    end

    def approver_is_listed?(name)
      approvers.any? do |item|
        item.name.text == name
      end
    end
  end
end
