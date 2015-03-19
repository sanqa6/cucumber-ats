module RecruiterSite
  class OfferApprovalProcessList < SitePrism::Section
    element :title, "td:nth-child(1) a"
    element :edit_link, ".icon-cell"
  end

  class OfferApprovalProcessPage < SitePrism::Page
    include Helpers

    set_url "/recruiter/#!/approval-workflows/"

    element :create_button, "#create-process"
    sections :list, OfferApprovalProcessList, "#approval-process-grid-table tbody tr"

    def click_create_button
      create_button.click
    end

    def select_row_by_title(title)
      wait_for_list
      list.detect do |item|
        item.title.text == title
      end
    end

    def row_is_present?(title)
      !select_row_by_title(title).nil?
    end

    def edit_approval_process(title)
      page.has_content?(title)
      approval_process = select_row_by_title(title)
      return nil if approval_process.nil?
      approval_process.edit_link.click
    end
  end
end
