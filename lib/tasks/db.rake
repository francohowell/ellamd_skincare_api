namespace :db do
  def annotate_models
    `annotate`
  end

  task :migrate do
    annotate_models
  end

  task :rollback do
    annotate_models
  end
end
