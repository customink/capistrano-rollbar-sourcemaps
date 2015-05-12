# Capistrano Rollbar Sourcemaps

Uploads sourcemaps for your application as a part of the Capistrano deploy
process. See the [Rollbar docs](https://rollbar.com/docs/source-maps/) for more
information on source map support in Rollbar.

Note that it is recommended to use this gem in conjunction with the [official
Rollbar gem](https://github.com/rollbar/rollbar-gem) but it is not required.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-rollbar-sourcemaps'
```

And then execute:

    $ bundle

## Usage

```ruby
require 'capistrano/rollbar/sourcemaps'
```

The task will run after `deploy:set_current_revision` by default

## Configurable options

### Required

```ruby
# For generating the minified_url that is passed to Rollbar on upload
set :rollbar_sourcemaps_minified_url_base, "http://www.example.com"

# Directory that will be searched for source maps to upload
set :rollbar_sourcemaps_target_dir, "./cache/my_app"
```

### Optional
```ruby
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
```
