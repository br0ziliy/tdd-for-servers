require 'spec_helper'

packages = %w(httpd mod_ssl libselinux-python)

packages.each {|package|
    describe package(package) do
      it { should be_installed }
    end
} # packages

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/var/www/html/index.html') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'nobody' }
  it { should be_grouped_into 'nobody' }
  its(:content) { should match /Hello, I'm a happy webapp!/ }
end # file

describe port(80) do
  it { should be_listening }
end
