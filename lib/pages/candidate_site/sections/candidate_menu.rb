class CandidateMenuSection < SitePrism::Section
  element :brand_link, ".navbar-brand > img"
  element :search_link, "a[href='#!/search']"
  element :about_link, "a[href='#!/about']"
  element :login_link, "a.loginaction"
  element :profil_link, "a.desktop-profile"
end
