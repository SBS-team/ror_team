class ContactController < ApplicationController
  def new
    @services = Service.all
    @tech_categories = TechnologyCategory.all
  end

  def create
     #получить данные из формы и запустить потомка ЭкшенМейлера ?
  end
end
