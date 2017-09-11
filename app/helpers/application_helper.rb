module ApplicationHelper
    include Rails.application.routes.url_helpers

    def cancel_link
      return link_to 'Cancelar', persons_list_view_path('index'), 
        :class => 'cancel', 
        :confirm => '¿Está seguro? Cualquier cambio se perderá.'
    end
end
