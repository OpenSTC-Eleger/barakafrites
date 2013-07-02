FactoryGirl.define do
  factory :intervention_request, :class => Openstc::InterventionRequest  do
=begin
    id
    create_uid
    intervention_assignement_id
    people_name
    note
    current_date
    manager_id
    confirm_by_dst
    people_phone
    partner_address
    partner_email
    description
    state
    people_email
    partner_type
    actions
    name
    partner_service_id
    site2
    site3
    site1
    partner_phone
    service_id
    intervention_ids
    href
=end
  end

end