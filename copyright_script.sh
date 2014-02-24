for i in (lib|app)/**/*.rb # or whatever other pattern...
do
  if ! grep -q Copyright $i
  then
    cat license_header.txt $i >$i.new && mv $i.new $i
  fi
done

