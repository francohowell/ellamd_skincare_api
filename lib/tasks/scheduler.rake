##
# These tasks are used by the Heroku Scheduler add-on.
namespace :scheduler do
  desc "Create upcoming visits"
  task create_upcoming_visits: :environment do
    Subscription.with_upcoming_visit.find_each do |subscription|
      ts = TransactionScripts::Visit::CreateUpcoming.new(subscription: subscription)
      ts.run
    end
  end

  desc "Run scraper"
  task scrape_all_stores: :environment do
    Product::Crawler.crawl_all_stores
  end

  task rebuild_search_index: :environment do
    Product::SearchIndex.rebuild
  end

  desc "Delivers the daily Physician email."
  task send_physician_daily_email: :environment do
    Physician.find_each { |physician| UserMailer.send_physician_daily_email(physician) }
  end

  desc "Alerts Admins of prescriptions not being downloaded 24 hours after being created"
  task send_not_downloaded_prescriptions_admin_alerts: :environment do
    Administrator.all.each do |admin|
      Prescription.not_downloaded_in_1_day.not_alerted_about_download.each do |prescription|
        AdminMailer.send_prescription_not_downloaded_admin_alert(prescription, admin)
        prescription.update(not_downloaded_alerted_at: DateTime.current)
      end
    end
  end

  desc "Alerts Admins of prescriptions without a tracking number 48 hours after being downloaded"
  task send_prescriptions_without_tracking_admin_alerts: :environment do
    Administrator.all.each do |admin|
      Prescription.not_shipped_in_2_days.not_alerted_about_shipping.each do |prescription|
        AdminMailer.send_prescription_without_tracking_admin_alert(prescription, admin)
        prescription.update(no_tracking_alerted_at: DateTime.current)
      end
    end
  end
end
