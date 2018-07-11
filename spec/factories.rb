FactoryBot.define do

  factory :auth_hash, class: OmniAuth::AuthHash do

    initialize_with do
      OmniAuth::AuthHash.new({
        provider: provider,
        uid: uid,
        info: {
          email: email
        }
      })
    end

    trait :google do
      provider "google_oauth2"
      sequence (:uid)
      email "testuser@gmail.com"
    end
  end

  factory :authorized_user do
    email "testuser@gmail.com"
  end

  factory :customer do
    Database "Test"
    BranchID "1"
    ClusterID "1"
    BillToID "12345"
    BillToCode "1"
    RoutePoint_AddUserID "1"
    RoutePoint_AddDate "20180101"
    RoutePoint_UpdateUserID "1"
    RoutePoint_UpdateDate "20180101"
    IsActiveServiceSetup "1"
    IsCreatedInLastTwoFiscalYears "1"
    IsCanceledInLastTwoFiscalYears "1"
    IsIncludedBySteritechLineOfBusiness "1"
    IsUpdatedSalesforce "1"
    IsUpdatedOB360 "1"
    InsertBy ""
    InsertDate "20180101"
    EffectiveDate "20180101"
    EndDate "99991231"
    IsReadyForIntegration "1"
  end


end
