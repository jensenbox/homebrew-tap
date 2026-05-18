class KvmSwitch < Formula
  desc "Cross-platform DDC/CI monitor input switcher (software KVM)"
  homepage "https://github.com/jensenbox/kvm-switch"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jensenbox/kvm-switch/releases/download/v0.2.0/kvm-switch-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "223e06c033a8dba2b236f512c6eeaf68e4d3eea7eea29ac8113a0f2696710e9f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jensenbox/kvm-switch/releases/download/v0.2.0/kvm-switch-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "90a89e7d0ce969ad726264b26569bb44968b30a7f8e8b7751ec206d147902682"
    end
  end

  def install
    bin.install "kvm-switch"
  end

  def caveats
    return unless OS.linux?

    <<~EOS
      kvm-switch on Linux needs read/write access to /dev/i2c-*. Add yourself
      to the i2c group, then log out and back in for the membership to take
      effect:

        sudo usermod -aG i2c "$USER"
    EOS
  end

  test do
    assert_match "Switch monitor input", shell_output("#{bin}/kvm-switch --help")
  end
end
