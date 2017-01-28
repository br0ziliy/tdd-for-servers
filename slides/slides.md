%title TDD for servers infrastructures
%author Vasyl Kaigorodov | Red Hat
%date 2017-01-27







-> TDD for servers infrastructures <-
=====================================





Vasyl Kaigorodov
PnT DevOps / SysOps
Red Hat


---
# About me

-> Run `git clone https://github.com/br0ziliy/tdd-for-servers.git` now! <-

- started with UNIX in 2003 with FreeBSD 4.6
- at 2012 joined Red Hat as Level 1 technical support engineer
- since late 2015 - senior system admin in Red Hat PnT DevOps,
  responsible for CI infrastructures
- have never worked as a QE
- know close to nothing about *software* testing

---
# Agenda

- What "TDD" stands for, or
  "Testing code - easy; testing infrastructures - ??? "
- Meet Serverspec!
  - What is Serverspec?
  - Getting started
  - Describing the infrastructure: *Rakefile*
  - Controlling the flow: *spec_helper.rb*
  - Exploring results: *Rake reports/formatters*
  - Suggested workflows
- Demo


---
# What is "TDD"?

> Test-driven development *(TDD)* is a _software_
> development process that relies on the repetition of a
> very short development cycle: *requirements* are turned
> into very specific *test cases*, then the _software_ is
> improved to pass the new tests, only. -- [Wikipedia](https://wikipedia.org/TDD)

---
# What is "TDD"?

Example (software)
------------------

_Requirement:_

password length must be more than 8
characters, but less than 512 characters

_Test case:_

- Check that `password` variable is set
- Check that `password` variable length is within the
  range `[9:512]`

_Implementation:_

some code that ensures the tests are passing

---
# What is "TDD for infrastructures"?

> Test-driven development *(TDD)* is a development process
> that relies on the repetition of a very short development
> cycle: *requirements* are turned into very specific *test*
> *cases*, then the _infrastructure_ is improved to pass the
> new tests, only. -- vk

---
# What is "TDD for infrastructures"?

Example (infrastructure)
------------------------

_Requirement:_ 

user `nobody` must have `/sbin/nologin` set as a login shell

_Test case:_ 

- Check that user `nobody` exists
- Check that user `nobody` have `/sbin/nologin` as a login shell

_Implementation_: 

`chsh -s /sbin/nologin nobody`

---
# Testing software - easy; testing infrastructures - ... ?

Software
--------

All kinds of tools provide unified way to run the tests:

- ${YOUR_FAVORITE_PL_NAME_HERE}Unit, PyTest, RSpec
- integration test suites, mocks
- etc

^
Infrastructure
--------------

~~~
# grep '^nobody:' /etc/passwd
# su - nobody
## UUCGA:
# cat /etc/passwd | grep '^nobody:' | grep `:/sbin/nologin`
~~~
^
~~~
# getent passwd nobody | \
  grep -q '/sbin/nologin' && \
  echo PASS || echo FAIL`
~~~

---
# Meet Serverspec!

- written in Ruby by [Gosuke Miyashita](http://mizzy.org/)
- [RSpec](http://rspec.info/) tests for servers
- checks the *actual state* of a server using
  SSH/WinRM/DockerAPI/etc
- official site/docs: [serverspec.org](http://serverspec.org/)
- looks like this:

^
~~~
describe user('nobody') do
  it { should exist }
  it { should have_login_shell '/sbin/nologin' }
end
~~~

---
# Getting started

- install Ruby 2.3.x - use [rbenv](https://github.com/rbenv/rbenv) or [RVM](https://rvm.io/)
- run:
~~~
gem install serverspec
mkdir infra-test
cd infra-test
serverspec-init
~~~

---
# Getting started

- contents of tests/00_default_setup:
~~~
.
├── Rakefile
└── spec
    ├── spec_helper.rb
    └── step00.example.local
        └── sample_spec.rb
~~~

Cons
----

- separate test set per server
- no roles
- DRY is not applicable

---
# Describing the infrastructure: Rakefile

- contents of tests/01_roles_and_shared_examples:
~~~
.
├── Rakefile
└── spec
    ├── spec_helper.rb
    ├── shared
    │   └── httpd
    │       └── basic.rb
    └── webapp01
        ├── app01.example.local_spec.rb
        └── app02.example.local_spec.rb
~~~
- alternatively - use YAML files to apply roles to servers

---
# Controlling the flow: spec_helper.rb

- set username / password
- control sudo
- set environment variables
- custom matchers / formatters / helpers
- shared test code

---
# Exploring results: Rake reports/formatters

- use `rspec_opts` to specify formatters
- tests/01_roles_and_shared_examples/Rakefile, line 31
- built-in formatters:
  - documentation
  - html
  - json
- I prefer have all 3 enabled

---
# Suggested workflows

Development of an Ansible role
------------------------------

- get the requirements
- translate requirements to Serverspec tests
- make sure the tests fail
- create Ansible roles/tasks that fix the tests
- make sure the tests pass
- start over

---
# Suggested workflows

Refactoring of an Ansible role
------------------------------

- choose a piece of role to rewrite
- write the Serverspec tests based on chosen tasks
- make changes to the role
- make sure the tests pass
- go to production

---
# Thank you!



IRC: vkaigoro / vk
GitHub: br0ziliy
vasyl@redhat.com





Presented with [mdp](https://github.com/visit1985/mdp) and [urxvt](http://linux.die.net/man/1/urxvt)


