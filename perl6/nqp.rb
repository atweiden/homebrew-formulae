class Nqp < Formula
  desc "A lightweight Perl 6-like environment for virtual machines, with MoarVM support"
  homepage "https://github.com/perl6/nqp"
  url "https://rakudo.perl6.org/downloads/nqp/nqp-2018.09.tar.gz"
  sha256 "8effea7b14a52a4c09a000bf6cde4cbf13385246af9b31a5da4dab27361ca905"

  head do
    url "https://github.com/perl6/nqp.git"
  end

  depends_on "moarvm"
  depends_on "moarvm" => :build
  depends_on "make" => :build
  depends_on "perl" => :build

  def install
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-moar=/usr/local/bin/moar"
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/nqp", "--version"
  end
end
