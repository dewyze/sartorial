task :compile do
  `sass scss/sartorial.scss css/sartorial.css`
  `sass examples/scss/site.scss examples/css/site.css`
  `slimrb --pretty examples/index.slim > examples/index.html`
end

task :watch do
  Rake::Task["compile"].invoke
  %x(
    fswatch -0 -r -e '.*' -i '.slim$' -i '.scss$' . | while read -d "" path
    do
      if [[ $path =~ \.slim$ ]] ; then
        slimrb --pretty $path > ${path//slim/html}
      elif [[ $path =~ \.scss$ ]] ; then
        sass scss/sartorial.scss css/sartorial.css
        sass examples/scss/site.scss examples/css/site.css
      fi
    done
  )
end
