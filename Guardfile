guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

disabled_options = ['0','false','n','no']

guard :process, name: 'Docker Compose', command: 'docker-compose -f docker-compose-services.yml up --force-recreate' do
  watch('docker-compose-services.yml')
end unless disabled_options.include?(ENV["DOCKER"].to_s.downcase)

guard :process, name: 'webpack', command: 'bin/webpack-dev-server' do
  watch('app/javascript/es_application.js')
end

guard :process, name: "Sidekiq", command: 'bundle exec sidekiq -c 2 -C config/sidekiq.yml' do
  watch(%r{^app/jobs/(.+)\.rb$})
end unless disabled_options.include?(ENV["SIDEKIQ"].to_s.downcase)

guard 'livereload' do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg,
  }

  rails_view_exts = %w(erb)

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+\.(#{rails_view_exts * '|'})$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{config/locales/.+\.yml})
end unless disabled_options.include?(ENV["LIVERELOAD"].to_s.downcase)
