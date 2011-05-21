namespace :cover_me do

  task :report do
    require 'cover_me'

    # I only care about code coverage on models
    CoverMe.config do |c|
      c.file_pattern = /(#{CoverMe.config.project.root}\/app\/models\/.+\.rb|#{CoverMe.config.project.root}\/lib\/.+\.rb)/i
    end
    CoverMe.complete!
  end

end

task :test do
  Rake::Task['cover_me:report'].invoke
end

task :spec do
  Rake::Task['cover_me:report'].invoke
end
