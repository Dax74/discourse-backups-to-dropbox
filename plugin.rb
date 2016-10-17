# name: discourse-backups-to-dropbox
# about: Backups discourse backups in dropbox
# version: 0.0.1
# authors: Rafael dos Santos Silva <xfalcox@gmail.com>
# url: https://github.com/xfalcox/discourse-backups-to-dropbox

gem 'addressable', '2.4.0', {require: false }
gem 'http_parser.rb', '0.6.0', {require: false }
gem 'http-form_data', '1.0.1', {require: false }

gem 'http', '2.0.3', {require: false }

gem 'dropbox-sdk-v2', '0.0.3', { require: false }

enabled_site_setting :discourse_backups_to_dropbox_enabled

require 'dropbox'

after_initialize do

  load File.expand_path("../app/jobs/regular/sync_backups_to_dropbox.rb", __FILE__)
  load File.expand_path("../lib/dropbox_synchronizer.rb", __FILE__)


  Backup.class_eval do
    def after_create_hook
      Jobs.enqueue(:sync_backups_to_dropbox)
    end
  end
end
