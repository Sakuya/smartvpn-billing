require 'spec_helper'

describe 'referrers page', js: true do
  let(:referrer1) { create(:user) }
  let(:referrer2) { create(:user) }
  let(:referral1_email) { referrer1.referrals.first.email }
  let(:referral2_email) { referrer2.referrals.first.email }

  before do
    2.times { create(:user, referrer: referrer1) }
    3.times { create(:user, referrer: referrer2) }
  end

  it 'toggles referrals on click on table line', disable_transaction: true do
    sign_in_admin
    visit admin_referrers_path

    # First referrer
    expect(page).not_to have_content referral1_email

    click_link referrer1.email
    expect(page).to have_content referral1_email

    click_link referrer1.email
    expect(page).not_to have_content referral1_email


    # Second referrer
    expect(page).not_to have_content referral2_email

    click_link referrer2.email
    expect(page).to have_content referral2_email

    click_link referrer2.email
    expect(page).not_to have_content referral2_email
  end
end
