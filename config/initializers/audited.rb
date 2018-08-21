Audited.config do |config|
  config.audit_class = Audit
  config.current_user_method = :current_identity
end
