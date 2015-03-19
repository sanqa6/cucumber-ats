module RecruiterSite
  class OfferTemplateListRow < SitePrism::Section
    element :title, "td:nth-child(1) a"
    element :modify_date, "td:nth-child(2)"
    element :clone_link, ".clone"
    element :edit_link, ".edit"
    element :delete_link, ".delete"
  end

  class OfferTemplateListPage < SitePrism::Page
    include Helpers

    set_url "/OfferTemplateManager.jsp"

    element :search_field, "#sname"
    element :search_button, "#searchbtn"
    element :create_button, "#createbtn"
    element :table_content, "#dataTable tbody"
    element :table_prev, "#dataTable_previous"
    element :table_next, "#dataTable_next"

    sections :list, OfferTemplateListRow, "tbody tr[role='row']"

    def search(text)
      search_field.set(text)
      search_button.click
      wait_for_ajax
    end

    def click_create_button
      create_button.click
    end

    def select_template_from_current_list(title)
      list.detect do |template|
        template.title.text == title
      end
    end

    def template_is_present?(title)
      !select_template_from_current_list(title).nil?
    end

    def clone(title)
      template = select_template_from_current_list(title)
      return nil if template.nil?
      template.clone_link.click
    end

    def edit(title)
      template = select_template_from_current_list(title)
      return nil if template.nil?
      template.edit_link.click
    end

    def delete(title)
      template = select_template_from_current_list(title)
      return nil if template.nil?
      template.delete_link.click
      page.driver.browser.switch_to.alert.accept
    end

  end
end
