require "FileUtils"
class Rakudo < Formula
  desc "Production-ready, stable implementation of the Perl 6 language"
  homepage "https://rakudo.org"
  url "https://rakudo.perl6.org/downloads/rakudo/rakudo-2018.10.tar.gz"
  sha256 "09f87ea4f869febceffe682f3391495cba829ae3119e7ea2e3d40b88b59cab45"
  head "https://github.com/rakudo/rakudo.git"

  depends_on "nqp"
  depends_on "nqp" => :build
  depends_on "make" => :build
  depends_on "perl" => :build

  def install
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-nqp=#{bin}/nqp"
    ]
    system "perl", "Configure.pl", *configure_args
    system "make"
    ENV["RAKUDO_LOG_PRECOMP"] = "1"
    ENV["RAKUDO_RERESOLVE_DEPENDENCIES"] = "0"
    system "make", "install"
    FileUtils.mv "tools/install-dist.p6", "tools/perl6-install-dist"
    bin.install "tools/perl6-install-dist"
  end

  test do
    out = `#{bin}/perl6 -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'`
    assert_equal "0123456789", out
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
