class Rakudo < Formula
  desc "Perl6 on MoarVM"
  homepage "https://github.com/rakudo/rakudo"
  url "https://codeload.github.com/rakudo/rakudo/tar.gz/2017.07"
  sha256 "93c74955bc954eef2e908137537f16f2e1d57e74dcd8097f42e46425914a493c"

  head do
    url "https://github.com/rakudo/rakudo.git"
  end

  depends_on "moarvm"
  depends_on "nqp"
  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "gdb" => :optional
  depends_on "valgrind" => :optional

  def install
    system "perl", "Configure.pl",
      "--prefix=#{prefix}",
      "--with-nqp=/usr/local/bin/nqp",
      "--backends=moar"
    system "make"
    ENV["RAKUDO_LOG_PRECOMP"] = "1"
    ENV["RAKUDO_RERESOLVE_DEPENDENCIES"] = "0"
    system "make", "install"
  end

  test do
    system "#{bin}/perl6", "--version"
  end
end
