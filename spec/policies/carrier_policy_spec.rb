# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarrierPolicy do
  subject(:instance) { described_class }

  let(:admin) { users(:admin) }
  let(:volunteer) { users(:volunteer) }
  let(:member) { users(:member) }

  %i[update? destroy?].each do |activity|
    permissions activity do
      it { is_expected.not_to permit(member) }
      it { is_expected.to permit(volunteer) }
      it { is_expected.to permit(admin) }
    end
  end

  permissions :create? do
    it { is_expected.not_to permit(member) }
    it { is_expected.not_to permit(volunteer) }
    it { is_expected.to permit(admin) }
  end

  permissions :checkout? do
    it { is_expected.not_to permit(member, carriers(:unavailable)) }

    it { is_expected.to permit(admin, carriers(:carrier)) }
  end
end
