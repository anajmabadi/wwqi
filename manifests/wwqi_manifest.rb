require 'erb'
require 'pathname'

class WwqiManifest < ShadowPuppet::Manifest
  recipe :system


  def system
    wkhtmltopdf
    mysql_client
    nginx 
  end

  ### TODO: Factor into modules..

  def wkhtmltopdf
    package 'wkhtmltopdf', :ensure => :installed
  end

  def mysql_client
    package 'mysql-client', :ensure => :installed
    package 'libmysqlclient-dev', :ensure => :installed
  end

  def nginx
    package 'nginx', :ensure => :installed

    service 'nginx', :ensure => :running, :require => [
      package('nginx')
    ]

    nginx_conf = template(File.join(File.dirname(__FILE__), 'templates', 'nginx.conf.erb'))

    file '/etc/nginx/sites-available/wwqi',
      :ensure => :present,
      :content => nginx_conf,
      :require => package('nginx'),
      :mode => '644'

    file "/etc/nginx/sites-enabled/wwqi",
      :ensure => "symlink",
      :target => "/etc/nginx/sites-available/wwqi",
      :require => [ file('/etc/nginx/sites-available/wwqi'), package('nginx') ],
      :notify => service('nginx')

  end

  def monit
    pagkage 'monit', :ensure => :installed
  end


  # Render the ERB template located at <tt>pathname</tt>. If a template exists
  # with the same basename at <tt>RAILS_ROOT/app/manifests/templates</tt>, it
  # is used instead. This is useful to override templates provided by plugins
  # to customize application configuration files.
  def template(pathname, b = binding)
    pathname = Pathname.new(pathname) unless pathname.kind_of?(Pathname)

    template_contents = if pathname.exist?
                          template_contents = pathname.read
                        else
                          raise LoadError, "Can't find template #{pathname}"
                        end
    ERB.new(template_contents).result(b)
  end
  

end
