# TDD for servers infrastructures

Slides and additional materials for "TDD for server infrastructure"
presentation.

To use Vagrantfile in tests/02_demo, you'll need:

- upstream [Vagrant](https://github.com/br0ziliy/tdd-for-servers) package installed
- LibVirt
- vagrant-libvirt and vagrant-hostmanager Vagrant plugins installed
- fedora-23 box imported

Below commands should set you up on Fedora:

```
sudo dnf install https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-hostmanager
vagrant box add https://dl.fedoraproject.org/pub/alt/purpleidea/vagrant/fedora-23/fedora-23.box
cd tests/02_demo
vagrant up
```
