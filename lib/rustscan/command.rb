require 'command_mapper/command'

module Rustscan
  class Command < CommandMapper::Command

    command 'rustscan' do
      option '--accessible'
      option '--greppable'
      option '--help'
      option '--no-config'
      option '--top'
      option '--version'
      option '--addresses', value: {type: List.new}
      option '--batch-size', value: {type: Num.new}
      option '--ports', value: {type: List.new(type: Num.new)}
      option '--scan-order', value: {type: Enum[:serial, :random]}
      option '--scripts', value: {type: Enum[:none, :default, :custom]}
      option '--timeout', value: {type: Num.new}
      option '--tries', value: {type: Num.new}
      option '--ulimit', value: {type: Num.new}

      argument :command, repeats: true, required: false
    end

  end
end
