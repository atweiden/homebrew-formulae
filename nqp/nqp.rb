class Nqp < Formula
  desc "Lightweight Perl 6-like environment for virtual machines"
  homepage "https://github.com/perl6/nqp"
  url "https://rakudo.perl6.org/downloads/nqp/nqp-2018.11.tar.gz"
  sha256 "3f8fe82484b18b29e455a9d581539f6d948f2f16d1503f42ca8a137a0bcd35b2"
  head "https://github.com/perl6/nqp.git"

  depends_on "make" => :build
  depends_on "moarvm" => :build
  depends_on "perl" => :build
  depends_on "moarvm"

  def install
    moarvm = Formula["moarvm"]
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-moar=#{moarvm.bin}/moar",
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/nqp", "--version"
  end
end
