class Nqp < Formula
  desc "Lightweight Perl6-like environment for virtual machines, with MoarVM support"
  homepage "https://github.com/perl6/nqp"
  url "https://codeload.github.com/perl6/nqp/tar.gz/2017.07"
  sha256 "3d23d97a1ae4aec7f287aa4e8dc1bb26922ce235d03da5972f6398053c345558"

  head do
    url "https://github.com/perl6/nqp.git"
  end

  depends_on "moarvm"
  depends_on "make" => :build
  depends_on "perl" => :build

  def install
    system "perl", "Configure.pl",
      "--prefix=#{prefix}",
      "--with-moar=/usr/local/bin/moar",
      "--backends=moar"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/nqp", "--version"
  end
end
