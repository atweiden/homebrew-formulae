class Aerc < Formula
  desc "Email client that runs in your terminal"
  homepage "https://aerc-mail.org/"
  url "https://git.sr.ht/~rjarry/aerc/archive/0.10.0.tar.gz"
  sha256 "14d6c622a012069deb1a31b51ecdd187fd11041c8e46f396ac22830b00e4c114"
  license "MIT"
  head "https://git.sr.ht/~rjarry/aerc", branch: "master"

  depends_on "go" => :build
  depends_on "scdoc" => :build
  # for showing HTML messages
  depends_on "dante"
  depends_on "w3m"

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}", "STRIP=true"
  end

  test do
    system "#{bin}/aerc", "-v"
  end
end
