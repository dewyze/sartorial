task :default => ["build"]

task :compile do
  system("sass scss/sartorial.scss css/sartorial.css")
end

task :build do
  system("bundle exec jekyll build")
end

task :serve do
  system("bundle exec jekyll serve")
end

task :watch do
  Rake::Task["compile"].invoke
  %x(
    fswatch -0 -r -e '.*' -i '.scss$' . | while read -d "" path
    do
      sass scss/sartorial.scss css/sartorial.css
    done
  )
end
