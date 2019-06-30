# frozen_string_literal: true

class DonationsController < ApplicationController
  load_and_authorize_resource

  def create
    amount = 1000
    @project = Project.includes(:benefits).find_by(id: params[:id])
    @donation = current_user.donations.build(amount: amount, project: @project)
    if @donation.save
      @project.benefits.each do |b|
        # Do not give benefit to the same user that sponsors it
        next if b.company.id == current_user.id

        # Do not give benefit if user already have it
        next if current_user.earned_benefits.find_by(id: b.id)

        UserBenefit.create(user: current_user, benefit: b, coupon_code: CouponCode.generate)
      end
      flash[:success] = t(:default, scope: %i[flash donation success], project: @project.name,
                                    amount: amount)
      return redirect_back fallback_location: :root
    else
      redirect_to :projects, flash: { error: t(:default, scope: %i[flash donation error]) }
    end
  end
end
