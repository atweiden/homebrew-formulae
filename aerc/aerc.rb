class Aerc < Formula
  desc "Pretty good email client"
  homepage "https://aerc-mail.org/"
  url "https://git.sr.ht/~sircmpwn/aerc/archive/0.4.0.tar.gz"
  sha256 "d369462cc0f76c33d804e586463e4d35d81fba9396ec08c3d3d0579e26091e17"

  depends_on "go" => :build
  depends_on "scdoc" => :build
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
