class Rakudo < Formula
  desc "Mature, production-ready implementation of the Raku language"
  homepage "https://rakudo.org"
  url "https://rakudo.org/dl/rakudo/rakudo-2022.07.tar.gz"
  sha256 "7a3bc9d654e1d2792a055b4faf116ef36d141f6b6adde7aa70317705f26090ad"
  license "Artistic-2.0"

  livecheck do
    url "https://github.com/rakudo/rakudo/releases"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "libtommath"
  depends_on "libuv"
  depends_on "nqp"
  depends_on "zstd"

  uses_from_macos "perl" => :build
  uses_from_macos "libffi"

  conflicts_with "rakudo-star"

  def install
    system "perl", "Configure.pl",
                   "--backends=moar",
                   "--prefix=#{prefix}",
                   "--with-nqp=#{Formula["nqp"].bin}/nqp"
    system "make"
    system "make", "install"
    bin.install "tools/install-dist.raku" => "raku-install-dist"
  end

  test do
    out = shell_output("#{bin}/raku -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'")
    assert_equal "0123456789", out
  end
end
