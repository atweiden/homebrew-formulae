class Nqp < Formula
  desc "A lightweight Perl 6-like environment for virtual machines, with MoarVM support"
  homepage "https://github.com/perl6/nqp"
  url "https://rakudo.perl6.org/downloads/nqp/nqp-2018.10.tar.gz"
  sha256 "ea97fd1ff3f9cf3efe10bcff8795bc0a6d1e0f316eb213f061c8fc1585f891c7"
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
