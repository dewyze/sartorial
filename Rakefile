task :compile do
  `sass scss/sartorial.scss css/sartorial.css`
  `slimrb --pretty examples/index.slim > examples/index.html`
end

task :watch do
  %x(
    fswatch -0 -r -e '.*' -i '.slim$' -i '.scss$' . | while read -d "" path
    do
      if [[ $path =~ \.slim$ ]] ; then
        slimrb --pretty $path > ${path//slim/html}
      elif [[ $path =~ \.scss$ ]] ; then
        sass scss/sartorial.scss css/sartorial.css
      fi
    done
  )
end
