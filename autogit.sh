# this scritp use to auto update files

new_file=$(git -ls-files --ohters --exclude-standard)
changed_file=$(git diff --name-only)
update_time=$(date +"%Y-%m-%d-%H-%M update")
