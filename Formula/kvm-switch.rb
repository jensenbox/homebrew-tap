class KvmSwitch < Formula
  desc "Cross-platform DDC/CI monitor input switcher (software KVM)"
  homepage "https://github.com/jensenbox/kvm-switch"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/jensenbox/kvm-switch/releases/download/v0.1.2/kvm-switch-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "17b2c6955b00d480393bf1697f8794646525d8fd0278ce54a2740c33a49d3795"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jensenbox/kvm-switch/releases/download/v0.1.2/kvm-switch-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5c6a75e7a70c016ae13e773403724764fdc18bf7a22402aa42787570ddde5fbd"
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
