require 'spec_helper'

hostname = File.basename($0).split("_")[0]

describe "#{hostname}" do
    include_examples 'httpd::basic'

    if os[:family] == 'redhat'
        docroot = '/var/www/html'
        user = 'nobody'
    elsif ['debian', 'ubuntu'].include?(os[:family])
        docroot = '/var/www'
        user = 'apache2'
    end
    describe file(docroot) do
        it { should be_directory }
        it { should be_mode 0755 }
        it { should be_owned_by user }
    end # file/docroot
    describe file("#{docroot}/index.html") do
        it { should be_file }
        its(:content) { should match /Hello, I'm a happy web application!/ }
    end

end # hostname
