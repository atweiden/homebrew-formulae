class Nqp < Formula
  desc "A lightweight Perl 6-like environment for virtual machines, with MoarVM support"
  homepage "https://github.com/perl6/nqp"
  url "https://rakudo.perl6.org/downloads/nqp/nqp-2018.11.tar.gz"
  sha256 "3f8fe82484b18b29e455a9d581539f6d948f2f16d1503f42ca8a137a0bcd35b2"
  head "https://github.com/perl6/nqp.git"

  depends_on "moarvm"
  depends_on "moarvm" => :build
  depends_on "make" => :build
  depends_on "perl" => :build

  def install
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-moar=#{Formula['moarvm'].bin}/moar"
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/nqp", "--version"
  end
end
