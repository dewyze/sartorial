task :compile do
  `sass scss/sartorial.scss css/sartorial.css`
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
