class Rakudo < Formula
  desc "Production-ready, stable implementation of the Perl 6 language"
  homepage "https://rakudo.org"
  url "https://rakudo.perl6.org/downloads/rakudo/rakudo-2018.11.tar.gz"
  sha256 "ad9ed66aaf45555cacc7f696ddafdb80ce9b659f36058e344593b5ca5edf22aa"
  head "https://github.com/rakudo/rakudo.git"

  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "nqp"

  def install
    nqp = Formula["nqp"]
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-nqp=#{nqp.bin}/nqp",
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    ENV["RAKUDO_LOG_PRECOMP"] = "1"
    ENV["RAKUDO_RERESOLVE_DEPENDENCIES"] = "0"
    system "make", "install"
    mv "tools/install-dist.p6", "tools/perl6-install-dist"
    bin.install "tools/perl6-install-dist"
  end

  test do
    out = `#{bin}/perl6 -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'`
    assert_equal "0123456789", out
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
