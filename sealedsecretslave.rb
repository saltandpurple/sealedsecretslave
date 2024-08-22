class SealedSecretSlave < Formula
  desc "A helper for sealed secret handling"
  homepage "https://github.com/saltandpurple/sealedsecretslave"
  url "https://github.com/saltandpurple/sealedsecretslave/releases/download/0.0.1/sealedsecretslave-0.0.1.tar.gz"
  sha256 "f983de3f33673a75db205ffb5991f563dcc978c75d7b80e1904daccfb4621224"
  license "MIT"

  def install
    bin.install "sealedsecretslave.sh"
    bin.install_symlink bin/"sealedsecretslave.sh" => "sss"
  end

  test do
    system "#{bin}/sss", "--version"
  end
end
