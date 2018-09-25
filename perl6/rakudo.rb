require "FileUtils"
class Rakudo < Formula
  desc "Production-ready, stable implementation of the Perl 6 language"
  homepage "https://rakudo.org"
  url "https://rakudo.perl6.org/downloads/rakudo/rakudo-2018.09.tar.gz"
  sha256 "4934b84f844adb61ec949b5f4fd31fbc86a83e2195fb2498a1bc2b77d9d859fb"

  head do
    url "https://github.com/rakudo/rakudo.git"
  end

  depends_on "nqp"
  depends_on "nqp" => :build
  depends_on "make" => :build
  depends_on "perl" => :build

  def install
    configure_args = [
      "--backends=moar",
      "--prefix=#{prefix}",
      "--with-nqp=/usr/local/bin/nqp"
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
