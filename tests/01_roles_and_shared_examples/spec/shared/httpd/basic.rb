shared_examples 'httpd::basic' do

    describe package('httpd') do
        it { should be_installed }
    end

end # shared_examples
