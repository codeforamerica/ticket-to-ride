module SupplementalMaterialParams
  def supplemental_material_params
    params.require(:supplemental_material).permit(
      :name,
      :description,
      :is_required
    )
  end
end