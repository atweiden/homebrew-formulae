class Aerc < Formula
  desc "Email client that runs in your terminal"
  homepage "https://aerc-mail.org/"
  url "https://git.sr.ht/~rjarry/aerc/archive/0.9.0.tar.gz"
  sha256 "b5901feb37a55edd1f713e76c1012ac3fc0757202ddacd7d388cc7ce60638023"
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
