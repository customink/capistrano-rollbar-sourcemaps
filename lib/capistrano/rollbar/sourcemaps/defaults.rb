# For generating the minified_url that is passed to Rollbar on upload
set :rollbar_sourcemaps_minified_url_base, -> { abort 'Please specify the minified URL for your minified javascript' }

# Directory that will be searched for source maps to upload
set :rollbar_sourcemaps_target_dir, -> { abort 'Please specify the directory from which your javascript sourcemaps will be uploaded'}

# Rollbar post_server_item token. Defaults to the rollbar_token used by the rollbar gem
set :rollbar_sourcemaps_token, -> { fetch :rollbar_token }

# Version of the sourcemaps for Rollbar. Uses the current_revision by default
set :rollbar_sourcemaps_version, -> { fetch :current_revision }

# Role under which sourcemaps should be uploaded
set :rollbar_sourcemaps_role, -> { fetch :rollbar_role }

# Glob pattern used to search for sourcemaps in the target_dir
set :rollbar_sourcemaps_glob_pattern, File.join('**', '*.js.map')

# Gsub pattern used to convert a sourcemap file to the associated JS file
set :rollbar_sourcemaps_gsub_pattern, /\.map\Z/
