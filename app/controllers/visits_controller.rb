class VisitsController < ApplicationController
  before_action :set_visit_from_params

  ##
  # Set the Diagnosis for a given Visit.
  def diagnosis
    authorize! :update_diagnosis, @visit

    diagnosis = @visit.diagnosis || @visit.build_diagnosis
    diagnosis.assign_attributes({
      note: params[:note],
      physician: @visit.customer.physician,
      customer: @visit.customer,
    })

    diagnosis.diagnosis_conditions.delete_all

    params[:conditions].each do |condition_id, description|
      diagnosis.diagnosis_conditions.build({
        condition_id: condition_id,
        description: description
      })
    end

    diagnosis.save!

    render json: @visit
  end

  ##
  # Set the Prescription for a given Visit.
  def prescription
    authorize! :update_prescription, @visit

    fields = params.permit(
      :volume_in_ml, :cream_base, :fragrance, :signa, :customer_instructions,
      :pharmacist_instructions
    ).merge(
      physician: @visit.customer.physician,
      formulation: Formulation.find_by(id: params[:formulation_id]),
      prescription_ingredients:
        initialize_prescription_ingredients(params[:prescription_ingredients]),
      customer: @visit.customer,
    )

    if @visit.prescription
      @visit.prescription.update!(fields)
    else
      TransactionScripts::Prescription::Create.new(params: fields.merge(visit: @visit)).run!
    end

    track("Created a prescription", prescription_id: @visit.prescription.id)
    track("Received a prescription", {prescription_id: @visit.prescription.id}, @visit.customer)

    @visit.customer.subscription.unblock_with_treatment_plan

    render json: @visit
  end

  def regimen
    authorize! :update_regimen, @visit

    regimen           = @visit.regimen || @visit.build_regimen
    regimen.customer  = @visit.customer
    regimen.physician = @visit.customer.physician

    ts = TransactionScripts::Regimen::Update.new(
      regimen: regimen,
      regimen_params: params[:regimen]
    )

    if ts.run
      if @visit == @visit.customer.current_visit
        @visit.customer.actual_regimen.make_copy_of(regimen)
        @visit.customer.actual_regimen.save!
      end

      render json: @visit
    else
      render json: {error: regimen.error}
    end
  end

  ##
  # Set the Photos (with Annotations) for a given Visit.
  def photos
    authorize! :update_photos, @visit

    # Remove this Visit's existing Photos.
    @visit.photos.each { |photo| photo.update!(visit: nil) }

    # Add Photos to Visit and add Annotations.
    params[:photos].each do |photo_param|
      @photo = Photo.find(photo_param[:id])
      @photo.update!(visit: @visit)
      @photo.annotations.destroy_all

      photo_param[:annotations].each do |annotation_param|
        @photo.annotations.create!(
          physician: @photo.customer.physician,
          position_x: annotation_param[:position_x],
          position_y: annotation_param[:position_y],
          note: annotation_param[:note],
        )
      end
    end

    render json: @visit.reload
  end

  def photo_conditions
    authorize! :update_photos, @visit

    # Remove this Visit's existing Photos.
    @visit.photos.each { |photo| photo.update!(visit: nil) }

    # Add Photos to Visit and add Annotations.
    params[:photos].each do |photo_param|
      @photo = Photo.find(photo_param[:id])
      @photo.update!(visit: @visit)

      @photo.photo_conditions.destroy_all
      photo_param[:photo_conditions].each do |photo_condition_param|
        @photo.photo_conditions.create!(
          condition_id: photo_condition_param[:condition][:id],
          note: photo_condition_param[:note],
          canvas_data: photo_condition_param[:canvas_data],
        )
      end
    end

    render json: @visit.reload
  end

  ##
  # Delete a given Visit.
  def delete
    authorize! :delete, @visit

    @customer = @visit.customer
    @visit.destroy!

    render json: @customer
  end

  ##
  # Process the given `prescription_ingredients` parameter to a set of initialized
  # PrescriptionIngredients with properly casted amounts, etc.
  private def initialize_prescription_ingredients(prescription_ingredients)
    prescription_ingredients
      .reject { |pi| pi[:amount].blank? || pi[:amount].to_f.zero? }
      .map do |pi|
        PrescriptionIngredient.new(
          ingredient: Ingredient.find(pi[:ingredient][:id]),
          amount: pi[:amount].to_f,
        )
      end
  end
end
