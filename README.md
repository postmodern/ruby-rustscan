# ruby-rustscan

[![CI](https://github.com/postmodern/ruby-rustscan/actions/workflows/ruby.yml/badge.svg)](https://github.com/postmodern/ruby-rustscan/actions/workflows/ruby.yml)
[![Gem Version](https://badge.fury.io/rb/ruby-rustscan.svg)](https://badge.fury.io/rb/ruby-rustscan)

* [Source](https://github.com/postmodern/ruby-rustscan/)
* [Issues](https://github.com/postmodern/ruby-rustscan/issues)
* [Documentation](http://rubydoc.info/gems/ruby-rustscan/frames)

## Description

A Ruby interface to [rustscan], the Modern Port Scanner.

## Features

* Provides a [Ruby interface][Rustscan::Command] for running the `rustscan`
  command.

[Rustscan::Command]: https://rubydoc.info/gems/ruby-rustscan/Rustscan/Command

## Examples

Run `rustscan --addresses 127.0.0.1 -p 80,443` from Ruby:

```ruby
require 'rustscan/command'

Rustscan::Command.run(addresses: ['127.0.0.1'], ports: [80, 443])
```

## Requirements

* [ruby] >= 2.0.0
* [rustscan] >= 2.0.0
* [command_mapper] ~> 0.2

[ruby]: https://www.ruby-lang.org/
[command_mapper]: https://github.com/postmodern/command_mapper.rb#readme

## Install

```shell
$ gem install ruby-rustscan
```

### gemspec

```ruby
gemspec.add_dependency 'ruby-rustscan', '~> 0.1'
```

### Gemfile

```ruby
gem 'ruby-rustscan', '~> 0.1'
```

## License

Copyright (c) 2022 Hal Brodigan

See {file:LICENSE.txt} for license information.

[rustscan]: https://github.com/OJ/rustscan#readme
