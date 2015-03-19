module RecruiterSite
  class OfferTemplateCreatePage < SitePrism::Page
    include Helpers

    set_url "/OfferTemplateDetail.jsp"

    element :name_field, "#name"
    element :next_button, ".next"
    element :cancel_button, ".cancel"
    element :save_button, ".save"
    element :create_template_button, ".btnCreateTemplate"
    element :label_field, "#fieldLabel"
    element :type_field, "#fieldType"
    element :add_field_button, "#btnFieldAddEdit"
    element :edit_field_container, "#editFieldContainer"
    element :textarea_row_field, "#textareaRows"
    element :create_offer_letter_button, ".btnCreateTemplate"
    element :offer_letter_listing, '#email-template-listing'
    element :letter_template_selector_button, '#letter-template-selector'
    elements :letter_template_checkboxes, '#letter-template-checklist input'
    section :offer_letter_form, '#email-template-container' do
      element :subject, "#txtSubject"
      element :name, "#txtTemplateName"
      element :add_letter_button, "#btn-submit"
    end

    def setName(name)
      name_field.set(name)
    end

    def next
      next_button.click
    end

    def add_field(label, type, options)
      label_field.set(label)
      type_field.select(type)
      textarea_row_field.set(options[:rows]) if type == 'Text Area'
      edit_field_container.find("#fieldRequired#{options[:required]}").click if !options[:required].nil?
      if (['Drop Down', 'Vertical Radio'].include? type)
        options[:options].each_with_index  do |answer, index|
          edit_field_container.find("input[name='multiselectLabel{#{index}}']").set(answer[:label])
          edit_field_container.find("input[name='multiselectValue{#{index}}']").set(answer[:value]) if answer[:value]
        end
      end

      add_field_button.click
    end

    def fill_in_offer_letter_content
      content = "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque varius vulputate magna ac feugiat. Ut rhoncus id augue vitae tristique. Nulla quis finibus eros. Praesent <strong>vulputate orci lectus</strong>, in dapibus nulla blandit nec. Ut lacinia in purus sed congue. Sed consequat leo a lacus commodo dapibus. Aliquam luctus purus ac nulla dignissim, id accumsan diam lacinia. Suspendisse potenti.&nbsp;</p><p>Quisque tincidunt t<s>ortor elit, in tempus nisl euismod sed</s>. Praesent at ipsum sed sem porttitor tempus ut id augue. Cras ac mollis dolor, nec condimentum velit. Morbi tristique libero odio, eget viverra felis ultrices semper. Maecenas non nibh tincidunt lacus venenatis imperdiet eget et neque. Cras mattis augue viverra egestas vehicula. Nulla vulputate, <u><em>lorem a varius scelerisque</em></u>, erat arcu sollicitudin mauris, id malesuada justo dolor et urna. Curabitur iaculis nisl faucibus, lacinia lectus ac, accumsan elit. Curabitur volutpat vitae lorem bibendum lacinia.&nbsp;</p><p>&nbsp;</p>"
      fill_in_ckeditor("txtEmailTemplate", { with: content })
    end

    def create_offer_letter
      name = 'Offer Letter Name Functional Testing'
      create_offer_letter_button.click
      offer_letter_form.name.set(name)
      offer_letter_form.subject.set('Offer Letter Subject Function Testing')
      fill_in_offer_letter_content
      offer_letter_form.add_letter_button.click
      wait_for_ajax
    end

    def select_first_offer_letter
      letter_template_selector_button.click
      wait_for_letter_template_checkboxes
      letter_template_checkboxes[0].click
    end


    def submit_offer_template
      save_button.click
      wait_for_ajax
    end

  end
end
