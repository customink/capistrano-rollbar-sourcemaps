require 'net/http/post/multipart'

namespace :rollbar do
  namespace :sourcemaps do
    def upload_sourcemap(s_map)
      debug "Uploading sourcemap #{s_map}"

      uri = URI.parse('https://api.rollbar.com/api/1/sourcemap')
      req = Net::HTTP::Post::Multipart.new uri.path,
        "access_token" => fetch(:rollbar_sourcemaps_token),
        "version" => fetch(:rollbar_sourcemaps_version),
        "minified_url" => minified_url_for(s_map),
        "source_map" => UploadIO.new(File.new(s_map), "application/octet-stream")

      #res = Net::HTTP.start(uri.host, uri.port) do |http|
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      res = http.request(req)

      begin
        res.value
      rescue
        info "Failed to upload sourcemap for #{s_map}. Error was #{res.code}: #{res.msg}"
      end
    end

    def minified_url_for(s_map)
      gsub_pattern = fetch(:rollbar_sourcemaps_gsub_pattern)
      url_base = fetch(:rollbar_sourcemaps_minified_url_base).dup
      url_base = url_base.prepend('http://') unless url_base.index(/https?:\/\//)

      url = URI.join(url_base, s_map.gsub(gsub_pattern, ''))
      debug "Minified url for #{s_map}: #{url}"
      url
    end

    desc 'Upload sourcemaps to Rollbar'
    task :upload do
      on roles fetch(:rollbar_sourcemaps_role) do
        debug "Uploading source maps from #{fetch(:rollbar_sourcemaps_target_dir)}"
        Dir.chdir fetch(:rollbar_sourcemaps_target_dir) do
          Dir.glob(fetch(:rollbar_sourcemaps_glob_pattern)).each do |s_map|
            upload_sourcemap(s_map)
          end
        end
      end
    end
  end
end
