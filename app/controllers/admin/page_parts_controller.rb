class Admin::PagePartsController < Admin::ResourceController
  # Need to use the PagePart initializer instead of delegating to the abstract model
  def create
    self.model = PagePart.new(params[model_symbol])
    render :partial => "page_part",
      :object => model,
      :locals => {:page_part_counter => params[:index].to_i, :page_part => model}
  end
end