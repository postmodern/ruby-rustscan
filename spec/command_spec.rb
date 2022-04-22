require 'spec_helper'
require 'rustscan/command'

describe Rustscan::Command do
  describe ".command_name" do
    subject { described_class }

    it "must be set to 'rustscan'" do
      expect(subject.command_name).to eq('rustscan')
    end
  end

  describe ":addresses" do
    let(:ip1) { '127.0.0.1'   }
    let(:ip2) { '192.168.1.1' }

    let(:addresses) { [ip1, ip2] }

    subject { described_class.new(addresses: addresses) }

    it "must map multiple addresses to --addresses and a comma separated list" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--addresses', "#{ip1},#{ip2}"]
      )
    end
  end

  describe ":batch_size" do
    let(:batch_size) { 10 }

    subject { described_class.new(batch_size: batch_size) }

    it "must map to --batch-size" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--batch-size', "#{batch_size}"]
      )
    end

    context "but when a non-number is given" do
      let(:batch_size) { "foo" }

      it "must only accept numeric values" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option batch_size was given an invalid value (#{batch_size.inspect}): contains non-numeric characters (#{batch_size.inspect})")
      end
    end
  end

  describe ":ports" do
    let(:port1) { 80   }
    let(:port2) { 443  }
    let(:port3) { 8080 }
    let(:ports) { [port1, port2, port3] }

    subject { described_class.new(ports: ports) }

    it "must map to --ports and a comma-separated list" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--ports', "#{port1},#{port2},#{port3}"]
      )
    end

    context "but when a non-number is given" do
      let(:port2) { "foo" }

      it "must only accept numeric values" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option ports was given an invalid value (#{ports.inspect}): element contains non-numeric characters (#{port2.inspect})")
      end
    end
  end

  describe ":scan_order" do
    context "when given :serial" do
      let(:scan_order) { :serial }

      subject { described_class.new(scan_order: scan_order) }

      it "must map to --scan-order serial" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--scan-order', "#{scan_order}"]
        )
      end
    end

    context "when given :random" do
      let(:scan_order) { :random }

      subject { described_class.new(scan_order: scan_order) }

      it "must map to --scan-order random" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--scan-order', "#{scan_order}"]
        )
      end
    end

    context "but when given an invalid scan order type" do
      let(:scan_order) { :foo }

      subject { described_class.new(scan_order: scan_order) }

      it "must only accept :serial or :random" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option scan_order was given an invalid value (#{scan_order.inspect}): unknown value (#{scan_order.inspect}) must be :serial, :random, or \"serial\", \"random\"")
      end
    end
  end

  describe ":scripts" do
    context "when given :none" do
      let(:scripts) { :none }

      subject { described_class.new(scripts: scripts) }

      it "must map to --scripts none" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--scripts', "#{scripts}"]
        )
      end
    end

    context "when given :default" do
      let(:scripts) { :default }

      subject { described_class.new(scripts: scripts) }

      it "must map to --scripts default" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--scripts', "#{scripts}"]
        )
      end
    end

    context "when given :custom" do
      let(:scripts) { :custom}

      subject { described_class.new(scripts: scripts) }

      it "must map to --scripts custom" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--scripts', "#{scripts}"]
        )
      end
    end

    context "but when given an invalid scan order type" do
      let(:scripts) { :foo }

      subject { described_class.new(scripts: scripts) }

      it "must only accept :none, :default, or :random" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option scripts was given an invalid value (#{scripts.inspect}): unknown value (#{scripts.inspect}) must be :none, :default, :custom, or \"none\", \"default\", \"custom\"")
      end
    end
  end

  describe ":timeout" do
    let(:timeout) { 10 }

    subject { described_class.new(timeout: timeout) }

    it "must map to --timeout" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--timeout', "#{timeout}"]
      )
    end

    context "but when a non-number is given" do
      let(:timeout) { "foo" }

      it "must only accept numeric values" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option timeout was given an invalid value (#{timeout.inspect}): contains non-numeric characters (#{timeout.inspect})")
      end
    end
  end

  describe ":tries" do
    let(:tries) { 10 }

    subject { described_class.new(tries: tries) }

    it "must map to --tries" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--tries', "#{tries}"]
      )
    end

    context "but when a non-number is given" do
      let(:tries) { "foo" }

      it "must only accept numeric values" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option tries was given an invalid value (#{tries.inspect}): contains non-numeric characters (#{tries.inspect})")
      end
    end
  end

  describe ":ulimit" do
    let(:ulimit) { 10 }

    subject { described_class.new(ulimit: ulimit) }

    it "must map to --ulimit" do
      expect(subject.command_argv).to eq(
        [subject.command_name, '--ulimit', "#{ulimit}"]
      )
    end

    context "but when a non-number is given" do
      let(:ulimit) { "foo" }

      it "must only accept numeric values" do
        expect {
          subject.command_argv
        }.to raise_error(CommandMapper::ValidationError,"option ulimit was given an invalid value (#{ulimit.inspect}): contains non-numeric characters (#{ulimit.inspect})")
      end
    end
  end

  describe ":command" do
    let(:addresses) { '127.0.0.1' }

    context "when given one value" do
      let(:command) { '-A' }

      subject { described_class.new(addresses: addresses, command: command) }

      it "must append the value to the end of the command" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--addresses', "#{addresses}", '--', command]
        )
      end
    end

    context "when given multiple values" do
      let(:command) { %w[-A -sC] }

      subject { described_class.new(addresses: addresses, command: command) }

      it "must append each value to the end of the command" do
        expect(subject.command_argv).to eq(
          [subject.command_name, '--addresses', "#{addresses}", '--', *command]
        )
      end
    end
  end
end
